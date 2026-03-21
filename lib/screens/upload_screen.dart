import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:studyspark/api/api_client.dart';
import 'package:studyspark/api/export.dart';
import 'package:studyspark/state/app_state.dart';
import 'package:dio/dio.dart';
import 'loading_screen.dart';
import 'dart:io';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  PlatformFile? _selectedFile;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchClerkToken = () async {
        return ClerkAuth.of(context).session?.lastActiveToken?.jwt;
      };
    });
  }

  Future<void> _pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );
      if (result != null) {
        setState(() {
          _selectedFile = result.files.first;
        });
      }
    } catch (_) {}
  }

  Future<void> _uploadAndCreate() async {
    if (_selectedFile == null || _selectedFile!.path == null) return;

    setState(() => _isUploading = true);

    try {
      // Fetch token directly here so it's always fresh and explicitly set
      final token =
          ClerkAuth.of(context).session?.lastActiveToken?.jwt;

      // Step 1: Upload file to storage
      final file = File(_selectedFile!.path!);
      final fileBytes = await file.readAsBytes();

      final uploadRes = await rawDio.post(
        '/storage/files',
        data: fileBytes,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'content-type': 'application/pdf',
            'x-file-name': _selectedFile!.name,
            'content-length': fileBytes.length.toString(),
          },
        ),
      );

      final fileId =
          (uploadRes.data?['data']?['id'] as String?) ?? '';

      // Step 2: Resolve profileId
      String profileId = AppState.profileId ?? '';
      if (profileId.isEmpty) {
        final profilesRes =
            await apiClient.profiles.getProfiles(status: Status2.all);
        final profiles = profilesRes.data;
        for (final p in profiles) {
            if (p.status == Status.ready) {
              AppState.profileId = p.id;
              profileId = p.id;
              break;
            }
          }
      }

      if (profileId.isEmpty) {
        throw Exception(
            'No learning profile found. Please complete the learning style quiz first.');
      }

      // Step 3: Create document record
      final docRes = await apiClient.documents.postDocuments(
        body: DocumentsRequestBody(fileId: fileId, profileId: profileId),
      );

      final documentId = docRes.data.id;
      if (!mounted) return;

      // Step 4: Navigate to loading/polling screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LoadingScreen(
            documentId: documentId,
            title: _selectedFile!.name
                .replaceAll('.pdf', '')
                .replaceAll('_', ' '),
            category: 'General',
          ),
        ),
      );
    } catch (e, st) {
      // ignore: avoid_print
      print('[Upload error] $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload failed: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Upload Learning Material',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      const Text(
                        'Upload Your PDF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      const Text(
                        "We'll analyze your document and create\npersonalized lessons based on your learning style.",
                        style: TextStyle(
                          color: Color(0xFF6B7A99),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      // Upload drop zone
                      InkWell(
                        onTap: _isUploading ? null : _pickPDF,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          height: screenHeight * 0.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _selectedFile != null
                                  ? const Color(0xFF6C63FF)
                                  : const Color(0xFF1E2A3A),
                              width: 1.5,
                            ),
                            color: _selectedFile != null
                                ? const Color(0xFF6C63FF)
                                    .withValues(alpha: 0.08)
                                : const Color(0xFF161B27),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: _selectedFile != null
                                      ? const Color(0xFF6C63FF)
                                          .withValues(alpha: 0.2)
                                      : Colors.white.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: Icon(
                                  _selectedFile != null
                                      ? Icons.picture_as_pdf
                                      : Icons.upload_outlined,
                                  color: _selectedFile != null
                                      ? const Color(0xFF6C63FF)
                                      : const Color(0xFF6B7A99),
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                _selectedFile != null
                                    ? _selectedFile!.name
                                    : 'Drop your PDF here or click\nto browse',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _selectedFile != null
                                      ? const Color(0xFF6C63FF)
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _selectedFile != null
                                    ? '${(_selectedFile!.size / (1024 * 1024)).toStringAsFixed(2)} MB'
                                    : 'Supports PDF files up to 10MB',
                                style: const TextStyle(
                                  color: Color(0xFF6B7A99),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      // Premium section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF161B27),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: const Color(0xFF1E2A3A)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFC107),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.workspace_premium,
                                      size: 14, color: Colors.black),
                                  SizedBox(width: 6),
                                  Text(
                                    'Premium Feature',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Upload handwritten notes & images',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF6B7A99), fontSize: 13),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 46,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF9800),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/premium'),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.lock_open,
                                        size: 16, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text(
                                      'Unlock Now',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      // How it works
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF161B27),
                          borderRadius: BorderRadius.circular(14),
                          border:
                              Border.all(color: const Color(0xFF1E2A3A)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How it works',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• Upload your study material (PDF)',
                              style: TextStyle(
                                  color: Color(0xFF6B7A99),
                                  fontSize: 13,
                                  height: 1.6),
                            ),
                            Text(
                              '• We analyze and personalize the content',
                              style: TextStyle(
                                  color: Color(0xFF6B7A99),
                                  fontSize: 13,
                                  height: 1.6),
                            ),
                            Text(
                              '• Lessons adapt to your VARK learning style',
                              style: TextStyle(
                                  color: Color(0xFF6B7A99),
                                  fontSize: 13,
                                  height: 1.6),
                            ),
                            Text(
                              '• Access Visual, Audio, Analytical & Story modes',
                              style: TextStyle(
                                  color: Color(0xFF6B7A99),
                                  fontSize: 13,
                                  height: 1.6),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Create button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedFile != null
                                ? const Color(0xFF6C63FF)
                                : const Color(0xFF1E2A3A),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          onPressed: (_selectedFile == null || _isUploading)
                              ? null
                              : _uploadAndCreate,
                          child: _isUploading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Create Personalized Lessons',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

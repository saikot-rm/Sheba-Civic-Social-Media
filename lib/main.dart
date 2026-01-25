import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';

// Supabase credentials
const String supabaseUrl = 'https://qlcsxlorkkhzqyaeykwe.supabase.co';
const String supabaseAnonKey = 'sb_publishable_-FYMcWs7cmpsG0yGs4Y88w_XNYJ0AVr';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  
  runApp(const ShebaApp());
}

final supabase = Supabase.instance.client;

class ShebaApp extends StatelessWidget {
  const ShebaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheba',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006A4E), // Bangladesh Green
          primary: const Color(0xFF006A4E),
          secondary: const Color(0xFFF42A41), // Bangladesh Red
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Bangladesh flag colors
  static const Color bdGreen = Color(0xFF006A4E);
  static const Color bdRed = Color(0xFFF42A41);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('সেবা', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
        backgroundColor: bdGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              bdGreen.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  'সেবায় স্বাগতম',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: bdGreen,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'আপনার নাগরিক সেবার সঙ্গী',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildServiceCard(
                  context,
                  icon: Icons.report_problem,
                  title: 'নাগরিক অভিযোগ',
                  subtitle: 'সমস্যা রিপোর্ট করুন',
                  color: bdRed,
                  imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CivicReportScreen()),
                  ),
                ),
                const SizedBox(height: 16),
                _buildServiceCard(
                  context,
                  icon: Icons.verified_user,
                  title: 'সম্পদ যাচাই',
                  subtitle: 'চুরি যাচাই করুন',
                  color: bdGreen,
                  imageUrl: 'https://images.unsplash.com/photo-1556656793-08538906a9f8?w=800',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AssetCheckScreen()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(icon, color: Colors.white, size: 40),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CivicReportScreen extends StatefulWidget {
  const CivicReportScreen({super.key});

  @override
  State<CivicReportScreen> createState() => _CivicReportScreenState();
}

class _CivicReportScreenState extends State<CivicReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'গর্ত';
  Uint8List? _selectedImageBytes;
  bool _isLoading = false;

  final List<String> _categories = [
    'গর্ত',
    'স্ট্রিট লাইট',
    'আবর্জনা',
    'পানি সরবরাহ',
    'অন্যান্য',
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() => _selectedImageBytes = bytes);
    }
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      String? imageUrl;
      
      // Try to upload image if selected (optional - skip if bucket doesn't exist)
      if (_selectedImageBytes != null) {
        try {
          final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
          
          await supabase.storage.from('reports').uploadBinary(
            fileName,
            _selectedImageBytes!,
            fileOptions: const FileOptions(upsert: true),
          );
          
          imageUrl = supabase.storage.from('reports').getPublicUrl(fileName);
        } catch (storageError) {
          // Storage bucket might not exist - continue without image
          debugPrint('Image upload skipped: $storageError');
        }
      }

      // Insert report into Supabase
      await supabase.from('reports').insert({
        'issue_type': _selectedCategory,
        'location': _locationController.text,
        'description': _descriptionController.text,
        'image_url': imageUrl,
        'status': 'pending',
      });

      setState(() => _isLoading = false);

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF006A4E), size: 28),
              const SizedBox(width: 8),
              Text('সফল!', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            'আপনার অভিযোগ সফলভাবে জমা হয়েছে!',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('ঠিক আছে', style: GoogleFonts.poppins()),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}', style: GoogleFonts.poppins()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('নাগরিক অভিযোগ', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF006A4E),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Text(
              'সমস্যা রিপোর্ট করুন',
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'আপনার এলাকার উন্নয়নে সহায়তা করুন',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'সমস্যার ধরন',
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.category),
              ),
              items: _categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat, style: GoogleFonts.poppins()));
              }).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'অবস্থান',
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.location_on),
              ),
              validator: (val) => val?.isEmpty ?? true ? 'অবস্থান লিখুন' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'বিবরণ',
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              validator: (val) => val?.isEmpty ?? true ? 'বিবরণ লিখুন' : null,
            ),
            const SizedBox(height: 16),
            if (_selectedImageBytes != null)
              Container(
                height: 200,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: MemoryImage(_selectedImageBytes!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            OutlinedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.camera_alt),
              label: Text(
                _selectedImageBytes == null ? 'ছবি যোগ করুন' : 'ছবি পরিবর্তন করুন',
                style: GoogleFonts.poppins(),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitReport,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: const Color(0xFF006A4E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text('জমা দিন', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class AssetCheckScreen extends StatefulWidget {
  const AssetCheckScreen({super.key});

  @override
  State<AssetCheckScreen> createState() => _AssetCheckScreenState();
}

class _AssetCheckScreenState extends State<AssetCheckScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imeiController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _result;

  Future<void> _checkAsset() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _result = null;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      // Mock check: "123456" is stolen
      if (_imeiController.text == '123456') {
        _result = {
          'status': 'stolen',
          'message': 'এই ডিভাইসটি চুরি হিসেবে রিপোর্ট করা হয়েছে!',
          'details': 'রিপোর্টের তারিখ: জানুয়ারি ১৫, ২০২৪',
        };
      } else {
        _result = {
          'status': 'safe',
          'message': 'এই ডিভাইসটি নিরাপদ এবং যাচাইকৃত।',
          'details': 'কোনো চুরির রিপোর্ট পাওয়া যায়নি।',
        };
      }
    });
  }

  @override
  void dispose() {
    _imeiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('সম্পদ যাচাই', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF006A4E),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Text(
              'সম্পদের নিরাপত্তা যাচাই',
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'IMEI বা সিরিয়াল নম্বর দিয়ে চুরির তথ্য যাচাই করুন',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _imeiController,
              decoration: InputDecoration(
                labelText: 'IMEI / সিরিয়াল নম্বর',
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.phone_android),
                hintText: 'ট্রাই করুন: 123456',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
              ),
              keyboardType: TextInputType.number,
              validator: (val) => val?.isEmpty ?? true ? 'IMEI লিখুন' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _checkAsset,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: const Color(0xFF006A4E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text('যাচাই করুন', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            if (_result != null) ...[
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _result!['status'] == 'stolen' ? Colors.red[50] : Colors.green[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _result!['status'] == 'stolen' ? Colors.red : Colors.green,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      _result!['status'] == 'stolen' ? Icons.warning : Icons.check_circle,
                      size: 64,
                      color: _result!['status'] == 'stolen' ? Colors.red : Colors.green,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _result!['message'],
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _result!['status'] == 'stolen' ? Colors.red[900] : Colors.green[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _result!['details'],
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

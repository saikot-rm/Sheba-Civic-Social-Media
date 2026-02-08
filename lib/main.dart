import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';
import 'dart:math' as math;

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

// ============== LOCALIZATION ==============
class AppLocalizations {
  final bool isBangla;
  
  AppLocalizations(this.isBangla);
  
  String get appName => isBangla ? 'সেবা' : 'Sheba';
  String get welcome => isBangla ? 'সেবায় স্বাগতম' : 'Welcome to Sheba';
  String get subtitle => isBangla ? 'আপনার নাগরিক সেবার সঙ্গী' : 'Your Civic Service Partner';
  String get civicReport => isBangla ? 'নাগরিক অভিযোগ' : 'Civic Report';
  String get reportIssue => isBangla ? 'সমস্যা রিপোর্ট করুন' : 'Report an Issue';
  String get assetCheck => isBangla ? 'সম্পদ যাচাই' : 'Asset Verification';
  String get verifyTheft => isBangla ? 'চুরি যাচাই করুন' : 'Check Theft Status';
  String get settings => isBangla ? 'সেটিংস' : 'Settings';
  String get darkMode => isBangla ? 'ডার্ক মোড' : 'Dark Mode';
  String get language => isBangla ? 'ভাষা' : 'Language';
  String get bangla => isBangla ? 'বাংলা' : 'Bangla';
  String get english => isBangla ? 'ইংরেজি' : 'English';
  String get issueType => isBangla ? 'সমস্যার ধরন' : 'Issue Type';
  String get location => isBangla ? 'অবস্থান' : 'Location';
  String get description => isBangla ? 'বিবরণ' : 'Description';
  String get addPhoto => isBangla ? 'ছবি যোগ করুন' : 'Add Photo';
  String get changePhoto => isBangla ? 'ছবি পরিবর্তন করুন' : 'Change Photo';
  String get submit => isBangla ? 'জমা দিন' : 'Submit';
  String get success => isBangla ? 'সফল!' : 'Success!';
  String get reportSubmitted => isBangla ? 'আপনার অভিযোগ সফলভাবে জমা হয়েছে!' : 'Your report has been submitted!';
  String get ok => isBangla ? 'ঠিক আছে' : 'OK';
  String get enterLocation => isBangla ? 'অবস্থান লিখুন' : 'Enter location';
  String get enterDescription => isBangla ? 'বিবরণ লিখুন' : 'Enter description';
  String get imeiSerial => isBangla ? 'IMEI / সিরিয়াল নম্বর' : 'IMEI / Serial Number';
  String get verify => isBangla ? 'যাচাই করুন' : 'Verify';
  String get enterImei => isBangla ? 'IMEI লিখুন' : 'Enter IMEI';
  String get deviceStolen => isBangla ? 'এই ডিভাইসটি চুরি হিসেবে রিপোর্ট করা হয়েছে!' : 'This device has been reported as stolen!';
  String get deviceSafe => isBangla ? 'এই ডিভাইসটি নিরাপদ এবং যাচাইকৃত।' : 'This device is safe and verified.';
  String get reportDate => isBangla ? 'রিপোর্টের তারিখ: জানুয়ারি ১৫, ২০২৪' : 'Report Date: January 15, 2024';
  String get noTheftReport => isBangla ? 'কোনো চুরির রিপোর্ট পাওয়া যায়নি।' : 'No theft report found.';
  String get tryExample => isBangla ? 'ট্রাই করুন: 123456' : 'Try: 123456';
  String get helpCommunity => isBangla ? 'আপনার এলাকার উন্নয়নে সহায়তা করুন' : 'Help improve your community';
  String get checkTheftInfo => isBangla ? 'IMEI দিয়ে চুরির তথ্য যাচাই করুন' : 'Check theft info using IMEI';
  String get postAs => isBangla ? 'পোস্ট করুন:' : 'Post as:';
  String get anonymous => isBangla ? 'বেনামী' : 'Anonymous';
  String get withAccount => isBangla ? 'অ্যাকাউন্ট দিয়ে' : 'With Account';
  String get login => isBangla ? 'লগইন' : 'Login';
  String get email => isBangla ? 'ইমেইল' : 'Email';
  String get password => isBangla ? 'পাসওয়ার্ড' : 'Password';
  String get loginToPost => isBangla ? 'পোস্ট করতে লগইন করুন' : 'Login to post';
  String get skipLogin => isBangla ? 'স্কিপ করুন' : 'Skip';
  String get postedAnonymously => isBangla ? 'বেনামীতে পোস্ট করা হবে' : 'Will be posted anonymously';
  String get postedWithAccount => isBangla ? 'অ্যাকাউন্ট দিয়ে পোস্ট করা হবে' : 'Will be posted with your account';
  
  // Community features
  String get community => isBangla ? 'কমিউনিটি' : 'Community';
  String get communityFeed => isBangla ? 'কমিউনিটি ফিড' : 'Community Feed';
  String get viewPosts => isBangla ? 'পোস্ট দেখুন' : 'View Posts';
  String get liveChat => isBangla ? 'লাইভ চ্যাট' : 'Live Chat';
  String get chatWithCommunity => isBangla ? 'সম্প্রদায়ের সাথে কথা বলুন' : 'Chat with community';
  String get upvote => isBangla ? 'আপভোট' : 'Upvote';
  String get downvote => isBangla ? 'ডাউনভোট' : 'Downvote';
  String get favorite => isBangla ? 'পছন্দের' : 'Favorite';
  String get save => isBangla ? 'সেভ' : 'Save';
  String get saved => isBangla ? 'সেভ করা হয়েছে' : 'Saved';
  String get follow => isBangla ? 'ফলো' : 'Follow';
  String get following => isBangla ? 'ফলো করছেন' : 'Following';
  String get comment => isBangla ? 'মন্তব্য' : 'Comment';
  String get comments => isBangla ? 'মন্তব্যসমূহ' : 'Comments';
  String get share => isBangla ? 'শেয়ার' : 'Share';
  String get writeMessage => isBangla ? 'বার্তা লিখুন...' : 'Write a message...';
  String get send => isBangla ? 'পাঠান' : 'Send';
  String get online => isBangla ? 'অনলাইন' : 'Online';
  String get members => isBangla ? 'সদস্য' : 'Members';
  String get trending => isBangla ? 'ট্রেন্ডিং' : 'Trending';
  String get recent => isBangla ? 'সাম্প্রতিক' : 'Recent';
  String get savedPosts => isBangla ? 'সেভ করা পোস্ট' : 'Saved Posts';
  String get favorites => isBangla ? 'পছন্দের তালিকা' : 'Favorites';
  String get noSavedPosts => isBangla ? 'কোনো সেভ করা পোস্ট নেই' : 'No saved posts';
  String get noFavorites => isBangla ? 'কোনো পছন্দের পোস্ট নেই' : 'No favorites';
  String get justNow => isBangla ? 'এইমাত্র' : 'Just now';
  String get minutesAgo => isBangla ? 'মিনিট আগে' : 'minutes ago';
  String get hoursAgo => isBangla ? 'ঘন্টা আগে' : 'hours ago';
  String get addedToFavorites => isBangla ? 'পছন্দের তালিকায় যোগ করা হয়েছে' : 'Added to favorites';
  String get removedFromFavorites => isBangla ? 'পছন্দের তালিকা থেকে সরানো হয়েছে' : 'Removed from favorites';
  String get postSaved => isBangla ? 'পোস্ট সেভ করা হয়েছে' : 'Post saved';
  String get postUnsaved => isBangla ? 'পোস্ট আনসেভ করা হয়েছে' : 'Post unsaved';
  
  List<String> get categories => isBangla 
    ? ['গর্ত', 'স্ট্রিট লাইট', 'আবর্জনা', 'পানি সরবরাহ', 'অন্যান্য']
    : ['Pothole', 'Street Light', 'Garbage', 'Water Supply', 'Others'];
}

// ============== POST MODEL ==============
class Post {
  final String id;
  final String authorName;
  final String? authorImage;
  final bool isAnonymous;
  final String content;
  final String? imageUrl;
  final String category;
  final String location;
  final DateTime createdAt;
  int upvotes;
  int downvotes;
  int commentCount;
  bool isUpvoted;
  bool isDownvoted;
  bool isFavorited;
  bool isSaved;
  bool isFollowing;

  Post({
    required this.id,
    required this.authorName,
    this.authorImage,
    this.isAnonymous = false,
    required this.content,
    this.imageUrl,
    required this.category,
    required this.location,
    required this.createdAt,
    this.upvotes = 0,
    this.downvotes = 0,
    this.commentCount = 0,
    this.isUpvoted = false,
    this.isDownvoted = false,
    this.isFavorited = false,
    this.isSaved = false,
    this.isFollowing = false,
  });
}

// ============== CHAT MESSAGE MODEL ==============
class ChatMessage {
  final String id;
  final String senderName;
  final String? senderImage;
  final String message;
  final DateTime timestamp;
  final bool isMe;

  ChatMessage({
    required this.id,
    required this.senderName,
    this.senderImage,
    required this.message,
    required this.timestamp,
    this.isMe = false,
  });
}

// ============== APP STATE ==============
class AppState extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isBangla = true;
  bool _isLoggedIn = false;
  String? _userEmail;
  
  final Set<String> _savedPostIds = {};
  final Set<String> _favoritedPostIds = {};
  final Set<String> _followingPostIds = {};
  final Map<String, int> _userVotes = {}; // postId -> 1 (upvote), -1 (downvote), 0 (none)
  
  bool get isDarkMode => _isDarkMode;
  bool get isBangla => _isBangla;
  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;
  AppLocalizations get loc => AppLocalizations(_isBangla);
  
  Set<String> get savedPostIds => _savedPostIds;
  Set<String> get favoritedPostIds => _favoritedPostIds;
  Set<String> get followingPostIds => _followingPostIds;
  
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
  
  void toggleLanguage() {
    _isBangla = !_isBangla;
    notifyListeners();
  }
  
  void login(String email) {
    _isLoggedIn = true;
    _userEmail = email;
    notifyListeners();
  }
  
  void logout() {
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();
  }
  
  bool isPostSaved(String postId) => _savedPostIds.contains(postId);
  bool isPostFavorited(String postId) => _favoritedPostIds.contains(postId);
  bool isPostFollowing(String postId) => _followingPostIds.contains(postId);
  int getVote(String postId) => _userVotes[postId] ?? 0;
  
  void toggleSave(String postId) {
    if (_savedPostIds.contains(postId)) {
      _savedPostIds.remove(postId);
    } else {
      _savedPostIds.add(postId);
    }
    notifyListeners();
  }
  
  void toggleFavorite(String postId) {
    if (_favoritedPostIds.contains(postId)) {
      _favoritedPostIds.remove(postId);
    } else {
      _favoritedPostIds.add(postId);
    }
    notifyListeners();
  }
  
  void toggleFollow(String postId) {
    if (_followingPostIds.contains(postId)) {
      _followingPostIds.remove(postId);
    } else {
      _followingPostIds.add(postId);
    }
    notifyListeners();
  }
  
  void vote(String postId, int value) {
    _userVotes[postId] = value;
    notifyListeners();
  }
}

// ============== MAIN APP ==============
class ShebaApp extends StatefulWidget {
  const ShebaApp({super.key});

  @override
  State<ShebaApp> createState() => _ShebaAppState();
}

class _ShebaAppState extends State<ShebaApp> {
  final AppState _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _appState,
      builder: (context, _) {
        return MaterialApp(
          title: 'Sheba',
          debugShowCheckedModeBanner: false,
          theme: _appState.isDarkMode ? _darkTheme : _lightTheme,
          home: SplashScreen(appState: _appState),
        );
      },
    );
  }
  
  ThemeData get _lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF2F2F7),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF007AFF),
      secondary: Color(0xFF34C759),
      surface: Colors.white,
      error: Color(0xFFFF3B30),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF2F2F7),
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    useMaterial3: true,
  );
  
  ThemeData get _darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF000000),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF0A84FF),
      secondary: Color(0xFF30D158),
      surface: Color(0xFF1C1C1E),
      error: Color(0xFFFF453A),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF000000),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    useMaterial3: true,
  );
}

// ============== SPLASH SCREEN ==============
class SplashScreen extends StatefulWidget {
  final AppState appState;
  const SplashScreen({super.key, required this.appState});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _rotateAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.linear),
    );
    
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    
    _fadeController.forward();
    
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => HomeScreen(appState: widget.appState),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.appState.isDarkMode 
              ? [const Color(0xFF1C1C1E), const Color(0xFF000000)]
              : [const Color(0xFF007AFF), const Color(0xFF5856D6)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: Listenable.merge([_pulseAnimation, _rotateAnimation]),
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.rotate(
                            angle: _rotateAnimation.value,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 3,
                                ),
                              ),
                              child: CustomPaint(painter: ArcPainter()),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              CupertinoIcons.hand_raised_fill,
                              size: 40,
                              color: Color(0xFF007AFF),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Text(
                  widget.appState.loc.appName,
                  style: GoogleFonts.inter(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.appState.loc.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 48),
                const LoadingDots(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(rect, 0, math.pi / 2, false, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) => AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    ));
    
    _animations = _controllers.map((c) => Tween<double>(begin: 0, end: -12).animate(
      CurvedAnimation(parent: c, curve: Curves.easeInOut),
    )).toList();
    
    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) _controllers[i].repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) { c.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) => AnimatedBuilder(
        animation: _animations[i],
        builder: (_, __) => Transform.translate(
          offset: Offset(0, _animations[i].value),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 10,
            height: 10,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
        ),
      )),
    );
  }
}

// ============== HOME SCREEN ==============
class HomeScreen extends StatelessWidget {
  final AppState appState;
  const HomeScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final loc = appState.loc;
        final isDark = appState.isDarkMode;
        
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(loc.welcome, style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text(loc.subtitle, style: GoogleFonts.inter(fontSize: 15, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => _showSettings(context),
                          child: Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(CupertinoIcons.gear, color: isDark ? Colors.white : Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Community Feed Card
                      _buildIOSCard(context, CupertinoIcons.person_3_fill, const Color(0xFF5856D6), loc.communityFeed, loc.viewPosts, () => Navigator.push(context, CupertinoPageRoute(builder: (_) => CommunityFeedScreen(appState: appState)))),
                      const SizedBox(height: 16),
                      // Live Chat Card
                      _buildIOSCard(context, CupertinoIcons.chat_bubble_2_fill, const Color(0xFF007AFF), loc.liveChat, loc.chatWithCommunity, () => Navigator.push(context, CupertinoPageRoute(builder: (_) => LiveChatScreen(appState: appState)))),
                      const SizedBox(height: 16),
                      // Civic Report Card
                      _buildIOSCard(context, CupertinoIcons.exclamationmark_triangle_fill, const Color(0xFFFF9500), loc.civicReport, loc.reportIssue, () => Navigator.push(context, CupertinoPageRoute(builder: (_) => CivicReportScreen(appState: appState)))),
                      const SizedBox(height: 16),
                      // Asset Check Card
                      _buildIOSCard(context, CupertinoIcons.shield_fill, const Color(0xFF34C759), loc.assetCheck, loc.verifyTheft, () => Navigator.push(context, CupertinoPageRoute(builder: (_) => AssetCheckScreen(appState: appState)))),
                      const SizedBox(height: 32),
                      _buildSettingsSection(isDark, loc),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIOSCard(BuildContext context, IconData icon, Color iconColor, String title, String subtitle, VoidCallback onTap) {
    final isDark = appState.isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(color: iconColor.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: GoogleFonts.inter(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                ],
              ),
            ),
            Icon(CupertinoIcons.chevron_right, color: isDark ? Colors.grey[600] : Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(bool isDark, AppLocalizations loc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: isDark ? const Color(0xFF1C1C1E) : Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFF5856D6).withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: const Icon(CupertinoIcons.moon_fill, color: Color(0xFF5856D6), size: 20)),
              const SizedBox(width: 12),
              Expanded(child: Text(loc.darkMode, style: GoogleFonts.inter(fontSize: 16))),
              CupertinoSwitch(value: appState.isDarkMode, onChanged: (_) => appState.toggleDarkMode(), activeTrackColor: const Color(0xFF007AFF)),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: isDark ? Colors.grey[800] : Colors.grey[200]),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFFFF9500).withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: const Icon(CupertinoIcons.globe, color: Color(0xFFFF9500), size: 20)),
              const SizedBox(width: 12),
              Expanded(child: Text(loc.language, style: GoogleFonts.inter(fontSize: 16))),
              CupertinoSlidingSegmentedControl<bool>(
                groupValue: appState.isBangla,
                children: {true: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('বাং', style: GoogleFonts.inter(fontSize: 13))), false: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('EN', style: GoogleFonts.inter(fontSize: 13)))},
                onValueChanged: (_) => appState.toggleLanguage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showCupertinoModalPopup(context: context, builder: (context) => SettingsSheet(appState: appState));
  }
}

class SettingsSheet extends StatelessWidget {
  final AppState appState;
  const SettingsSheet({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final loc = appState.loc;
        final isDark = appState.isDarkMode;
        return Container(
          height: 380,
          decoration: BoxDecoration(color: isDark ? const Color(0xFF1C1C1E) : Colors.white, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(3))),
              const SizedBox(height: 20),
              Text(loc.settings, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFF5856D6).withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: const Icon(CupertinoIcons.moon_fill, color: Color(0xFF5856D6), size: 20)), const SizedBox(width: 12), Expanded(child: Text(loc.darkMode, style: GoogleFonts.inter(fontSize: 16))), CupertinoSwitch(value: appState.isDarkMode, onChanged: (_) => appState.toggleDarkMode())]),
                    const SizedBox(height: 16),
                    Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFFFF9500).withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: const Icon(CupertinoIcons.globe, color: Color(0xFFFF9500), size: 20)), const SizedBox(width: 12), Expanded(child: Text(loc.language, style: GoogleFonts.inter(fontSize: 16))), CupertinoSlidingSegmentedControl<bool>(groupValue: appState.isBangla, children: {true: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(loc.bangla)), false: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(loc.english))}, onValueChanged: (_) => appState.toggleLanguage())]),
                    const SizedBox(height: 16),
                    // Saved Posts
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, CupertinoPageRoute(builder: (_) => SavedPostsScreen(appState: appState)));
                      },
                      child: Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFF007AFF).withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: const Icon(CupertinoIcons.bookmark_fill, color: Color(0xFF007AFF), size: 20)), const SizedBox(width: 12), Expanded(child: Text(loc.savedPosts, style: GoogleFonts.inter(fontSize: 16))), Icon(CupertinoIcons.chevron_right, color: Colors.grey[400], size: 18)]),
                    ),
                    const SizedBox(height: 16),
                    // Favorites
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, CupertinoPageRoute(builder: (_) => FavoritesScreen(appState: appState)));
                      },
                      child: Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFFFF3B30).withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: const Icon(CupertinoIcons.star_fill, color: Color(0xFFFF3B30), size: 20)), const SizedBox(width: 12), Expanded(child: Text(loc.favorites, style: GoogleFonts.inter(fontSize: 16))), Icon(CupertinoIcons.chevron_right, color: Colors.grey[400], size: 18)]),
                    ),
                    if (appState.isLoggedIn) ...[const SizedBox(height: 16), Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFF007AFF).withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: const Icon(CupertinoIcons.person_fill, color: Color(0xFF007AFF), size: 20)), const SizedBox(width: 12), Expanded(child: Text(appState.userEmail ?? '', style: GoogleFonts.inter(fontSize: 16))), CupertinoButton(padding: EdgeInsets.zero, child: Text('Logout', style: GoogleFonts.inter(color: const Color(0xFFFF3B30))), onPressed: () => appState.logout())])],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============== COMMUNITY FEED SCREEN ==============
class CommunityFeedScreen extends StatefulWidget {
  final AppState appState;
  const CommunityFeedScreen({super.key, required this.appState});

  @override
  State<CommunityFeedScreen> createState() => _CommunityFeedScreenState();
}

class _CommunityFeedScreenState extends State<CommunityFeedScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Post> _posts;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializePosts();
  }
  
  void _initializePosts() {
    _posts = [
      Post(
        id: '1',
        authorName: 'রহিম উদ্দিন',
        isAnonymous: false,
        content: 'ধানমন্ডি ২৭ নম্বর রোডে বড় গর্ত। গাড়ি চলাচলে অনেক সমস্যা হচ্ছে। দ্রুত মেরামত প্রয়োজন।',
        category: 'Pothole',
        location: 'Dhanmondi, Dhaka',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        upvotes: 45,
        downvotes: 3,
        commentCount: 12,
      ),
      Post(
        id: '2',
        authorName: 'Anonymous',
        isAnonymous: true,
        content: 'মিরপুর ১০ নম্বরে স্ট্রিট লাইট নষ্ট প্রায় দুই সপ্তাহ ধরে। রাতে হাঁটতে ভয় লাগে।',
        category: 'Street Light',
        location: 'Mirpur-10, Dhaka',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        upvotes: 78,
        downvotes: 2,
        commentCount: 23,
      ),
      Post(
        id: '3',
        authorName: 'সালমা বেগম',
        isAnonymous: false,
        content: 'উত্তরায় আবর্জনা সংগ্রহ হচ্ছে না গত ৫ দিন। দুর্গন্ধে এলাকাবাসী অতিষ্ঠ।',
        imageUrl: 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=800',
        category: 'Garbage',
        location: 'Uttara, Dhaka',
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
        upvotes: 156,
        downvotes: 5,
        commentCount: 45,
      ),
      Post(
        id: '4',
        authorName: 'করিম সাহেব',
        isAnonymous: false,
        content: 'গুলশান ১-এ পানির লাইনে সমস্যা। সকাল থেকে পানি আসছে না। পরিবারের সকলে কষ্টে আছি।',
        category: 'Water Supply',
        location: 'Gulshan-1, Dhaka',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        upvotes: 89,
        downvotes: 4,
        commentCount: 34,
      ),
      Post(
        id: '5',
        authorName: 'Anonymous',
        isAnonymous: true,
        content: 'মহাখালীতে নতুন ফ্লাইওভারের নিচে অবৈধ দোকান বসেছে। যানজট সৃষ্টি হচ্ছে প্রতিদিন।',
        category: 'Others',
        location: 'Mohakhali, Dhaka',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        upvotes: 234,
        downvotes: 12,
        commentCount: 67,
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getTimeAgo(DateTime dateTime) {
    final loc = widget.appState.loc;
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return loc.justNow;
    if (diff.inMinutes < 60) return '${diff.inMinutes} ${loc.minutesAgo}';
    if (diff.inHours < 24) return '${diff.inHours} ${loc.hoursAgo}';
    return '${diff.inDays}d';
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.appState,
      builder: (context, _) {
        final loc = widget.appState.loc;
        final isDark = widget.appState.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            leading: CupertinoButton(padding: EdgeInsets.zero, child: const Icon(CupertinoIcons.back), onPressed: () => Navigator.pop(context)),
            title: Text(loc.communityFeed, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF007AFF),
              labelColor: const Color(0xFF007AFF),
              unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
              tabs: [
                Tab(child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(CupertinoIcons.flame_fill, size: 18), const SizedBox(width: 6), Text(loc.trending)])),
                Tab(child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(CupertinoIcons.clock_fill, size: 18), const SizedBox(width: 6), Text(loc.recent)])),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildPostsList(_posts..sort((a, b) => b.upvotes.compareTo(a.upvotes))),
              _buildPostsList(_posts..sort((a, b) => b.createdAt.compareTo(a.createdAt))),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPostsList(List<Post> posts) {
    final isDark = widget.appState.isDarkMode;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      itemBuilder: (context, index) => _buildPostCard(posts[index], isDark),
    );
  }

  Widget _buildPostCard(Post post, bool isDark) {
    final loc = widget.appState.loc;
    final isFavorited = widget.appState.isPostFavorited(post.id);
    final isSaved = widget.appState.isPostSaved(post.id);
    final isFollowing = widget.appState.isPostFollowing(post.id);
    final userVote = widget.appState.getVote(post.id);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: post.isAnonymous ? Colors.grey[600] : const Color(0xFF007AFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    post.isAnonymous ? CupertinoIcons.person_crop_circle_badge_xmark : CupertinoIcons.person_fill,
                    color: Colors.white, size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.isAnonymous ? loc.anonymous : post.authorName,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      Row(
                        children: [
                          Icon(CupertinoIcons.location_solid, size: 12, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(post.location, style: GoogleFonts.inter(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                          const SizedBox(width: 8),
                          Text('• ${_getTimeAgo(post.createdAt)}', style: GoogleFonts.inter(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
                // Follow button
                GestureDetector(
                  onTap: () {
                    setState(() => widget.appState.toggleFollow(post.id));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isFollowing ? const Color(0xFF007AFF) : (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      isFollowing ? loc.following : loc.follow,
                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: isFollowing ? Colors.white : const Color(0xFF007AFF)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Category Badge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(post.category).withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(post.category, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: _getCategoryColor(post.category))),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(post.content, style: GoogleFonts.inter(fontSize: 15, height: 1.5)),
          ),
          
          // Image
          if (post.imageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
              child: Image.network(post.imageUrl!, height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
          
          // Voting and Actions
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                // Upvote/Downvote
                _buildVoteButton(
                  CupertinoIcons.arrow_up_circle_fill,
                  post.upvotes + (userVote == 1 ? 1 : 0) - (post.isUpvoted ? 1 : 0),
                  userVote == 1,
                  const Color(0xFF34C759),
                  () {
                    setState(() {
                      if (userVote == 1) {
                        widget.appState.vote(post.id, 0);
                      } else {
                        widget.appState.vote(post.id, 1);
                      }
                    });
                  },
                ),
                const SizedBox(width: 4),
                _buildVoteButton(
                  CupertinoIcons.arrow_down_circle_fill,
                  post.downvotes + (userVote == -1 ? 1 : 0) - (post.isDownvoted ? 1 : 0),
                  userVote == -1,
                  const Color(0xFFFF3B30),
                  () {
                    setState(() {
                      if (userVote == -1) {
                        widget.appState.vote(post.id, 0);
                      } else {
                        widget.appState.vote(post.id, -1);
                      }
                    });
                  },
                ),
                
                const SizedBox(width: 16),
                
                // Comments
                _buildActionButton(CupertinoIcons.chat_bubble_fill, post.commentCount.toString(), false, isDark ? Colors.grey[400]! : Colors.grey[600]!, () {}),
                
                const Spacer(),
                
                // Favorite (Star)
                GestureDetector(
                  onTap: () {
                    setState(() => widget.appState.toggleFavorite(post.id));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isFavorited ? loc.removedFromFavorites : loc.addedToFavorites),
                        duration: const Duration(seconds: 1),
                        backgroundColor: const Color(0xFFFF9500),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      isFavorited ? CupertinoIcons.star_fill : CupertinoIcons.star,
                      color: isFavorited ? const Color(0xFFFF9500) : (isDark ? Colors.grey[400] : Colors.grey[600]),
                      size: 22,
                    ),
                  ),
                ),
                
                // Save (Bookmark)
                GestureDetector(
                  onTap: () {
                    setState(() => widget.appState.toggleSave(post.id));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isSaved ? loc.postUnsaved : loc.postSaved),
                        duration: const Duration(seconds: 1),
                        backgroundColor: const Color(0xFF007AFF),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                      color: isSaved ? const Color(0xFF007AFF) : (isDark ? Colors.grey[400] : Colors.grey[600]),
                      size: 22,
                    ),
                  ),
                ),
                
                // Share
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Icon(CupertinoIcons.share, color: isDark ? Colors.grey[400] : Colors.grey[600], size: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoteButton(IconData icon, int count, bool isActive, Color activeColor, VoidCallback onTap) {
    final isDark = widget.appState.isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: isActive ? activeColor : (isDark ? Colors.grey[400] : Colors.grey[600])),
            const SizedBox(width: 4),
            Text(
              count.toString(),
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: isActive ? activeColor : (isDark ? Colors.grey[400] : Colors.grey[600])),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, bool isActive, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 4),
          Text(label, style: GoogleFonts.inter(fontSize: 13, color: color)),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Pothole': return const Color(0xFFFF9500);
      case 'Street Light': return const Color(0xFFFFCC00);
      case 'Garbage': return const Color(0xFF8E8E93);
      case 'Water Supply': return const Color(0xFF007AFF);
      default: return const Color(0xFF5856D6);
    }
  }
}

// ============== LIVE CHAT SCREEN ==============
class LiveChatScreen extends StatefulWidget {
  final AppState appState;
  const LiveChatScreen({super.key, required this.appState});

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessage> _messages;
  final int _onlineCount = 127;

  @override
  void initState() {
    super.initState();
    _initializeMessages();
  }

  void _initializeMessages() {
    _messages = [
      ChatMessage(id: '1', senderName: 'আব্দুল করিম', message: 'আসসালামু আলাইকুম সবাইকে', timestamp: DateTime.now().subtract(const Duration(minutes: 45))),
      ChatMessage(id: '2', senderName: 'সালমা আক্তার', message: 'ওয়ালাইকুম আসসালাম। আজ কেমন আছেন সবাই?', timestamp: DateTime.now().subtract(const Duration(minutes: 42))),
      ChatMessage(id: '3', senderName: 'রহিম মিয়া', message: 'ধানমন্ডিতে আজ রাস্তা কাটা শুরু হয়েছে। সবাই সাবধানে থাকবেন।', timestamp: DateTime.now().subtract(const Duration(minutes: 38))),
      ChatMessage(id: '4', senderName: 'নাজমা বেগম', message: 'কোন রাস্তায়? আমি জানতাম না তো!', timestamp: DateTime.now().subtract(const Duration(minutes: 35))),
      ChatMessage(id: '5', senderName: 'রহিম মিয়া', message: '২৭ নম্বর রোডে। ওয়াসা কাজ করছে।', timestamp: DateTime.now().subtract(const Duration(minutes: 33))),
      ChatMessage(id: '6', senderName: 'কামরুল হাসান', message: 'গুলশানে পানির সমস্যা সমাধান হয়েছে শুনলাম। কেউ confirm করতে পারবেন?', timestamp: DateTime.now().subtract(const Duration(minutes: 25))),
      ChatMessage(id: '7', senderName: 'জাহিদ সাহেব', message: 'হ্যাঁ, দুপুর থেকে পানি আসছে।', timestamp: DateTime.now().subtract(const Duration(minutes: 22))),
      ChatMessage(id: '8', senderName: 'মনিরা খাতুন', message: 'মিরপুরে কি অবস্থা? সেখানেও কি সমস্যা সমাধান হয়েছে?', timestamp: DateTime.now().subtract(const Duration(minutes: 18))),
      ChatMessage(id: '9', senderName: 'সোহেল রানা', message: 'মিরপুর ১০-এ এখনো সমস্যা আছে। রাতে দেখা যাবে।', timestamp: DateTime.now().subtract(const Duration(minutes: 15))),
      ChatMessage(id: '10', senderName: 'তানভীর আহমেদ', message: 'সবাইকে আমার রিপোর্টে upvote দেওয়ার জন্য ধন্যবাদ! 🙏', timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
    ];
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add(ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderName: widget.appState.userEmail ?? 'আপনি',
        message: _messageController.text.trim(),
        timestamp: DateTime.now(),
        isMe: true,
      ));
    });
    
    _messageController.clear();
    
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.appState,
      builder: (context, _) {
        final loc = widget.appState.loc;
        final isDark = widget.appState.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            leading: CupertinoButton(padding: EdgeInsets.zero, child: const Icon(CupertinoIcons.back), onPressed: () => Navigator.pop(context)),
            title: Column(
              children: [
                Text(loc.liveChat, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 17)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF34C759), shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text('$_onlineCount ${loc.online}', style: GoogleFonts.inter(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                  ],
                ),
              ],
            ),
            actions: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.person_2_fill),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              // Messages List
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) => _buildMessageBubble(_messages[index], isDark),
                ),
              ),
              
              // Message Input
              Container(
                padding: EdgeInsets.only(
                  left: 16, right: 16, top: 12,
                  bottom: MediaQuery.of(context).padding.bottom + 12,
                ),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                  border: Border(top: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: loc.writeMessage,
                            hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          style: GoogleFonts.inter(),
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        width: 44, height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFF007AFF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(CupertinoIcons.paperplane_fill, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isDark) {
    final isMe = message.isMe;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF007AFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  message.senderName[0],
                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFF007AFF) : (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7)),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMe)
                    Text(
                      message.senderName,
                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF007AFF)),
                    ),
                  if (!isMe) const SizedBox(height: 2),
                  Text(
                    message.message,
                    style: GoogleFonts.inter(fontSize: 15, color: isMe ? Colors.white : null),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: GoogleFonts.inter(fontSize: 10, color: isMe ? Colors.white.withOpacity(0.7) : Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
          
          if (isMe) const SizedBox(width: 40),
        ],
      ),
    );
  }
}

// ============== SAVED POSTS SCREEN ==============
class SavedPostsScreen extends StatelessWidget {
  final AppState appState;
  const SavedPostsScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final loc = appState.loc;
        final isDark = appState.isDarkMode;
        final savedCount = appState.savedPostIds.length;
        
        return Scaffold(
          appBar: AppBar(
            leading: CupertinoButton(padding: EdgeInsets.zero, child: const Icon(CupertinoIcons.back), onPressed: () => Navigator.pop(context)),
            title: Text(loc.savedPosts, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
          body: savedCount == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.bookmark, size: 64, color: isDark ? Colors.grey[600] : Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(loc.noSavedPosts, style: GoogleFonts.inter(fontSize: 17, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: savedCount,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.bookmark_fill, color: Color(0xFF007AFF)),
                        const SizedBox(width: 12),
                        Expanded(child: Text('${loc.saved} Post #${index + 1}', style: GoogleFonts.inter())),
                      ],
                    ),
                  );
                },
              ),
        );
      },
    );
  }
}

// ============== FAVORITES SCREEN ==============
class FavoritesScreen extends StatelessWidget {
  final AppState appState;
  const FavoritesScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final loc = appState.loc;
        final isDark = appState.isDarkMode;
        final favCount = appState.favoritedPostIds.length;
        
        return Scaffold(
          appBar: AppBar(
            leading: CupertinoButton(padding: EdgeInsets.zero, child: const Icon(CupertinoIcons.back), onPressed: () => Navigator.pop(context)),
            title: Text(loc.favorites, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
          body: favCount == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.star, size: 64, color: isDark ? Colors.grey[600] : Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(loc.noFavorites, style: GoogleFonts.inter(fontSize: 17, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favCount,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.star_fill, color: Color(0xFFFF9500)),
                        const SizedBox(width: 12),
                        Expanded(child: Text('${loc.favorite} Post #${index + 1}', style: GoogleFonts.inter())),
                      ],
                    ),
                  );
                },
              ),
        );
      },
    );
  }
}

// ============== CIVIC REPORT SCREEN ==============
class CivicReportScreen extends StatefulWidget {
  final AppState appState;
  const CivicReportScreen({super.key, required this.appState});

  @override
  State<CivicReportScreen> createState() => _CivicReportScreenState();
}

class _CivicReportScreenState extends State<CivicReportScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _selectedCategoryIndex = 0;
  Uint8List? _selectedImageBytes;
  bool _isLoading = false;
  bool _postAnonymously = true;
  
  late AnimationController _loadingController;

  final List<IconData> _categoryIcons = [CupertinoIcons.circle_fill, CupertinoIcons.lightbulb_fill, CupertinoIcons.trash_fill, CupertinoIcons.drop_fill, CupertinoIcons.ellipsis];

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
  }

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

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
    _loadingController.repeat();

    try {
      String? imageUrl;
      final loc = widget.appState.loc;
      
      // Try to upload image if selected
      if (_selectedImageBytes != null) {
        try {
          final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
          await supabase.storage.from('reports').uploadBinary(fileName, _selectedImageBytes!, fileOptions: const FileOptions(upsert: true));
          imageUrl = supabase.storage.from('reports').getPublicUrl(fileName);
        } catch (e) { 
          debugPrint('Image upload skipped: $e'); 
        }
      }

      // Try to submit to Supabase
      try {
        await supabase.from('reports').insert({
          'issue_type': loc.categories[_selectedCategoryIndex],
          'location': _locationController.text,
          'description': _descriptionController.text,
          'image_url': imageUrl,
          'status': 'pending',
          'is_anonymous': _postAnonymously,
          'user_email': _postAnonymously ? null : widget.appState.userEmail,
        });
      } catch (dbError) {
        // Database might not be set up yet, continue with demo mode
        debugPrint('Database insert skipped (demo mode): $dbError');
      }

      _loadingController.stop();
      setState(() => _isLoading = false);
      if (!mounted) return;
      _showSuccessDialog();
    } catch (e) {
      _loadingController.stop();
      setState(() => _isLoading = false);
      if (!mounted) return;
      // Still show success in demo mode
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    final loc = widget.appState.loc;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(CupertinoIcons.checkmark_circle_fill, color: Color(0xFF34C759), size: 24), const SizedBox(width: 8), Text(loc.success)]),
        content: Padding(padding: const EdgeInsets.only(top: 8), child: Text(loc.reportSubmitted)),
        actions: [CupertinoDialogAction(child: Text(loc.ok), onPressed: () { Navigator.pop(context); Navigator.pop(context); })],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.appState,
      builder: (context, _) {
        final loc = widget.appState.loc;
        final isDark = widget.appState.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            leading: CupertinoButton(padding: EdgeInsets.zero, child: const Icon(CupertinoIcons.back), onPressed: () => Navigator.pop(context)),
            title: Text(loc.civicReport, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(loc.reportIssue, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(loc.helpCommunity, style: GoogleFonts.inter(fontSize: 15, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                const SizedBox(height: 24),
                _buildPostAsSection(isDark, loc),
                const SizedBox(height: 24),
                Text(loc.issueType, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                _buildCategorySelector(isDark, loc),
                const SizedBox(height: 24),
                _buildTextField(_locationController, loc.location, CupertinoIcons.location_fill, (val) => val?.isEmpty ?? true ? loc.enterLocation : null, isDark),
                const SizedBox(height: 16),
                _buildTextField(_descriptionController, loc.description, CupertinoIcons.doc_text_fill, (val) => val?.isEmpty ?? true ? loc.enterDescription : null, isDark, maxLines: 4),
                const SizedBox(height: 16),
                if (_selectedImageBytes != null) AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: MemoryImage(_selectedImageBytes!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedImageBytes = null),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(CupertinoIcons.xmark, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(CupertinoIcons.photo_fill, color: Colors.white, size: 16),
                                const SizedBox(width: 6),
                                Text(loc.isBangla ? 'ছবি সিলেক্ট করা হয়েছে' : 'Photo selected', style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CupertinoButton(padding: EdgeInsets.zero, onPressed: _pickImage, child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7), borderRadius: BorderRadius.circular(12), border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[300]!)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(CupertinoIcons.camera_fill, color: Color(0xFF007AFF), size: 22), const SizedBox(width: 8), Text(_selectedImageBytes == null ? loc.addPhoto : loc.changePhoto, style: GoogleFonts.inter(color: const Color(0xFF007AFF), fontWeight: FontWeight.w500))]))),
                const SizedBox(height: 32),
                _buildSubmitButton(loc),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostAsSection(bool isDark, AppLocalizations loc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: isDark ? const Color(0xFF1C1C1E) : Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const Icon(CupertinoIcons.person_2_fill, color: Color(0xFF007AFF), size: 20), const SizedBox(width: 8), Text(loc.postAs, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600))]),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: GestureDetector(onTap: () => setState(() => _postAnonymously = true), child: AnimatedContainer(duration: const Duration(milliseconds: 200), padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: _postAnonymously ? const Color(0xFF007AFF) : (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7)), borderRadius: BorderRadius.circular(10)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(CupertinoIcons.person_crop_circle_badge_xmark, color: _postAnonymously ? Colors.white : Colors.grey, size: 20), const SizedBox(width: 6), Text(loc.anonymous, style: GoogleFonts.inter(color: _postAnonymously ? Colors.white : (isDark ? Colors.white : Colors.black), fontWeight: FontWeight.w500))])))),
              const SizedBox(width: 12),
              Expanded(child: GestureDetector(onTap: () { if (!widget.appState.isLoggedIn) { _showLoginSheet(); } else { setState(() => _postAnonymously = false); } }, child: AnimatedContainer(duration: const Duration(milliseconds: 200), padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: !_postAnonymously ? const Color(0xFF007AFF) : (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7)), borderRadius: BorderRadius.circular(10)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(CupertinoIcons.person_crop_circle_fill, color: !_postAnonymously ? Colors.white : Colors.grey, size: 20), const SizedBox(width: 6), Text(widget.appState.isLoggedIn ? loc.withAccount : loc.login, style: GoogleFonts.inter(color: !_postAnonymously ? Colors.white : (isDark ? Colors.white : Colors.black), fontWeight: FontWeight.w500))])))),
            ],
          ),
          const SizedBox(height: 8),
          Text(_postAnonymously ? loc.postedAnonymously : loc.postedWithAccount, style: GoogleFonts.inter(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
        ],
      ),
    );
  }

  void _showLoginSheet() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final loc = widget.appState.loc;
    
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 350,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: widget.appState.isDarkMode ? const Color(0xFF1C1C1E) : Colors.white, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          children: [
            Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(3))),
            const SizedBox(height: 20),
            Text(loc.loginToPost, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            CupertinoTextField(controller: emailController, placeholder: loc.email, prefix: const Padding(padding: EdgeInsets.only(left: 12), child: Icon(CupertinoIcons.mail_solid, size: 20)), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: widget.appState.isDarkMode ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7), borderRadius: BorderRadius.circular(12))),
            const SizedBox(height: 12),
            CupertinoTextField(controller: passwordController, placeholder: loc.password, obscureText: true, prefix: const Padding(padding: EdgeInsets.only(left: 12), child: Icon(CupertinoIcons.lock_fill, size: 20)), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: widget.appState.isDarkMode ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7), borderRadius: BorderRadius.circular(12))),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: CupertinoButton(color: const Color(0xFFF2F2F7), child: Text(loc.skipLogin, style: const TextStyle(color: Colors.black87)), onPressed: () => Navigator.pop(context))),
                const SizedBox(width: 12),
                Expanded(child: CupertinoButton.filled(child: Text(loc.login), onPressed: () { if (emailController.text.isNotEmpty) { widget.appState.login(emailController.text); setState(() => _postAnonymously = false); Navigator.pop(context); } })),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector(bool isDark, AppLocalizations loc) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(loc.categories.length, (i) {
          final isSelected = _selectedCategoryIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategoryIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(color: isSelected ? const Color(0xFF007AFF) : (isDark ? const Color(0xFF2C2C2E) : Colors.white), borderRadius: BorderRadius.circular(20), border: Border.all(color: isSelected ? const Color(0xFF007AFF) : (isDark ? Colors.grey[700]! : Colors.grey[300]!))),
              child: Row(children: [Icon(_categoryIcons[i], size: 16, color: isSelected ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[600])), const SizedBox(width: 6), Text(loc.categories[i], style: GoogleFonts.inter(fontSize: 14, color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black), fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400))]),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, String? Function(String?) validator, bool isDark, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: GoogleFonts.inter(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(color: isDark ? Colors.grey[400] : Colors.grey[600]),
        prefixIcon: Icon(icon, color: const Color(0xFF007AFF)),
        filled: true,
        fillColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF007AFF), width: 2)),
      ),
    );
  }

  Widget _buildSubmitButton(AppLocalizations loc) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: _isLoading ? null : _submitReport,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF007AFF), Color(0xFF5856D6)]), borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: const Color(0xFF007AFF).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))]),
        child: Center(child: _isLoading ? const CupertinoActivityIndicator(color: Colors.white) : Text(loc.submit, style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white))),
      ),
    );
  }
}

// ============== ASSET CHECK SCREEN ==============
class AssetCheckScreen extends StatefulWidget {
  final AppState appState;
  const AssetCheckScreen({super.key, required this.appState});

  @override
  State<AssetCheckScreen> createState() => _AssetCheckScreenState();
}

class _AssetCheckScreenState extends State<AssetCheckScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _imeiController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _result;
  
  late AnimationController _scanController;
  late Animation<double> _scanAnimation;
  late AnimationController _resultController;
  late Animation<double> _resultAnimation;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _scanAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _scanController, curve: Curves.easeInOut));
    _resultController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _resultAnimation = CurvedAnimation(parent: _resultController, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _imeiController.dispose();
    _scanController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  Future<void> _checkAsset() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _isLoading = true; _result = null; });
    _scanController.repeat();

    await Future.delayed(const Duration(seconds: 2));
    
    _scanController.stop();
    _scanController.reset();

    final loc = widget.appState.loc;
    setState(() {
      _isLoading = false;
      if (_imeiController.text == '123456') {
        _result = {'status': 'stolen', 'message': loc.deviceStolen, 'details': loc.reportDate};
      } else {
        _result = {'status': 'safe', 'message': loc.deviceSafe, 'details': loc.noTheftReport};
      }
    });
    _resultController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.appState,
      builder: (context, _) {
        final loc = widget.appState.loc;
        final isDark = widget.appState.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            leading: CupertinoButton(padding: EdgeInsets.zero, child: const Icon(CupertinoIcons.back), onPressed: () => Navigator.pop(context)),
            title: Text(loc.assetCheck, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Container(
                    width: 100, height: 100,
                    decoration: BoxDecoration(color: const Color(0xFF34C759).withOpacity(0.15), shape: BoxShape.circle),
                    child: _isLoading ? _buildScanningAnimation() : const Icon(CupertinoIcons.shield_fill, size: 50, color: Color(0xFF34C759)),
                  ),
                ),
                const SizedBox(height: 24),
                Text(loc.assetCheck, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                const SizedBox(height: 4),
                Text(loc.checkTheftInfo, style: GoogleFonts.inter(fontSize: 15, color: isDark ? Colors.grey[400] : Colors.grey[600]), textAlign: TextAlign.center),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _imeiController,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.inter(),
                  validator: (val) => val?.isEmpty ?? true ? loc.enterImei : null,
                  decoration: InputDecoration(
                    labelText: loc.imeiSerial,
                    labelStyle: GoogleFonts.inter(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                    hintText: loc.tryExample,
                    hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
                    prefixIcon: const Icon(CupertinoIcons.device_phone_portrait, color: Color(0xFF007AFF)),
                    filled: true,
                    fillColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF007AFF), width: 2)),
                  ),
                ),
                const SizedBox(height: 24),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _isLoading ? null : _checkAsset,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF34C759), Color(0xFF30D158)]), borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: const Color(0xFF34C759).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))]),
                    child: Center(child: Text(loc.verify, style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white))),
                  ),
                ),
                if (_result != null) ...[
                  const SizedBox(height: 32),
                  AnimatedBuilder(animation: _resultAnimation, builder: (_, child) => Transform.scale(scale: _resultAnimation.value, child: child), child: _buildResultCard(isDark)),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScanningAnimation() {
    return AnimatedBuilder(
      animation: _scanAnimation,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(angle: _scanAnimation.value * 2 * math.pi, child: Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF34C759).withOpacity(0.3), width: 3)), child: CustomPaint(painter: ScanArcPainter(color: const Color(0xFF34C759))))),
            Transform.scale(scale: 0.8 + (math.sin(_scanAnimation.value * math.pi * 2) * 0.2), child: const Icon(CupertinoIcons.search, size: 32, color: Color(0xFF34C759))),
          ],
        );
      },
    );
  }

  Widget _buildResultCard(bool isDark) {
    final isStolen = _result!['status'] == 'stolen';
    final color = isStolen ? const Color(0xFFFF3B30) : const Color(0xFF34C759);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: color.withOpacity(isDark ? 0.15 : 0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.3), width: 2)),
      child: Column(
        children: [
          Container(width: 72, height: 72, decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle), child: Icon(isStolen ? CupertinoIcons.exclamationmark_triangle_fill : CupertinoIcons.checkmark_shield_fill, size: 36, color: color)),
          const SizedBox(height: 16),
          Text(_result!['message'], style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600, color: isStolen ? (isDark ? const Color(0xFFFF6961) : const Color(0xFFD32F2F)) : (isDark ? const Color(0xFF81C784) : const Color(0xFF388E3C))), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(_result!['details'], style: GoogleFonts.inter(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey[600]), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class ScanArcPainter extends CustomPainter {
  final Color color;
  ScanArcPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 4..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(rect, 0, math.pi / 2, false, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

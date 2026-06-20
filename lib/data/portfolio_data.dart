class SocialLink {
  final String label; final String url;
  const SocialLink(this.label, this.url);
}
class SkillGroup {
  final String title; final String emoji; final List<String> items;
  const SkillGroup(this.title, this.emoji, this.items);
}
class SoftSkill {
  final String title; final String description; final String icon;
  const SoftSkill(this.title, this.description, this.icon);
}
class ServiceItem {
  final String title, description, icon;
  final List<String> features;
  const ServiceItem({required this.title,required this.description,required this.icon,required this.features});
}
class ProjectScreenshot {
  final String assetPath; final String caption;
  const ProjectScreenshot(this.assetPath, this.caption);
}
class Project {
  final String title, subtitle, problem, solution, yourRole;
  final List<String> technologies, features, tags;
  final String repoUrl, liveUrl;
  final List<int> gradient, accentColor;
  final List<ProjectScreenshot> screenshots;
  final String? demoVideoPath;
  const Project({
    required this.title, required this.subtitle,
    required this.problem, required this.solution,
    required this.technologies, required this.features,
    required this.yourRole, required this.tags,
    required this.repoUrl, required this.liveUrl,
    required this.gradient, required this.accentColor,
    this.screenshots = const [], this.demoVideoPath,
  });
}
class Experience {
  final String role, org, duration, location;
  final List<String> points;
  const Experience({required this.role,required this.org,required this.duration,required this.location,required this.points});
}

class PortfolioData {
  static const name        = 'Hamayun Saeed';
  static const initials    = 'HS';
  static const headline    = 'Full Stack Mobile App Developer';
  static const profileImage = 'assets/images/profile_image.jpeg'; // <-- apni photo yahan rakh dena

  static const roles = [
    'Android App Developer',
    'Flutter Developer',
    'Backend Developer',
    'AI-Powered App Builder',
    'Full Stack Mobile Dev',
  ];

  static const tagline =
      'I build complete mobile solutions beautiful frontends, '
      'scalable backends & AI-powered features that clients love.';

  static const aboutText =
      'I am a passionate Full Stack Mobile App Developer with hands-on '
      'experience building high-performance apps using Flutter and Android '
      '(Kotlin/Java). My backend skills in Node.js and MongoDB let me '
      'deliver end-to-end solutions — clean UI, scalable APIs, real-time '
      'features, and Firebase integration. I also integrate cutting-edge AI '
      'capabilities into mobile apps to give products a real competitive edge. '
      'Whether a startup MVP or a production system, I bring the full stack.';

  static const email    = 'hamayunsaeed48@gmail.com';
  static const phone    = '+92 308 4720312';
  static const location = 'Fortabbas, Punjab, Pakistan';

  // <-- Apne real social links yahan update karo
  static const socials = [
    SocialLink('GitHub',   'https://github.com/hamayunsaeed48github'),
    SocialLink('LinkedIn', 'www.linkedin.com/in/hamayun-saeed-585957185'),
    SocialLink('Upwork',   'https://www.upwork.com/freelancers/~01cf9fda34b4a0b360'),
    SocialLink("Fiver", "https://www.fiverr.com/s/NNRqxqp"),
    SocialLink('Email',    'mailto:hamayunsaeed48@gmail.com'),
  ];

  static const services = [
    ServiceItem(title:'Android App Development',icon:'📱',
      description:'Native Android apps with Kotlin & Jetpack Compose — pixel-perfect UI, smooth performance, Play Store ready.',
      features:['Kotlin & Java (Jetpack Compose / XML)','MVVM Architecture','Room / SQLite local storage','Firebase & REST API integration','Push notifications (FCM)']),
    ServiceItem(title:'Flutter Cross-Platform Apps',icon:'🦋',
      description:'One codebase — Android, iOS & Web. Beautiful responsive UI with silky-smooth animations.',
      features:['Flutter / Dart','State management (Provider, Riverpod, BLoC)','Google Maps & real-time location','Socket.IO live communication','Firebase & REST API integration']),
    ServiceItem(title:'Backend & API Development',icon:'⚙️',
      description:'Scalable RESTful APIs and real-time backends that power your mobile apps reliably at any scale.',
      features:['Node.js & Express.js','MongoDB with Mongoose','JWT & Firebase Authentication','Socket.IO (real-time)','Firebase Cloud Functions']),
    ServiceItem(title:'AI-Powered Mobile Apps',icon:'🤖',
      description:'Integrating AI into mobile apps — chatbots, smart recommendations, image recognition & LLM-powered screens.',
      features:['OpenAI / Gemini API integration','AI chatbot in Flutter & Android','Smart search & recommendations','Image classification (ML Kit)','Natural language features']),
    ServiceItem(title:'Firebase & Cloud Solutions',icon:'☁️',
      description:'Full Firebase setup — auth, Firestore, FCM, Cloud Functions, Storage — so your app scales without managing servers.',
      features:['Firebase Authentication','Firestore real-time database','Firebase Cloud Messaging (FCM)','Firebase Storage','Firebase Cloud Functions']),
    ServiceItem(title:'Full Stack Project Delivery',icon:'🚀',
      description:'End-to-end delivery: requirements, design, development, testing, and Play Store / App Store release.',
      features:['Requirements & architecture planning','UI/UX design implementation','Frontend + backend development','Testing & QA','Deployment & post-launch support']),
    ServiceItem(title:'Play Store & App Store Publishing',icon:'🏪',
      description:'I handle the complete app publishing process — from store listing setup and screenshots to submission, review and live launch on both Google Play Store and Apple App Store.',
      features:['Google Play Store end-to-end submission','Apple App Store (TestFlight & live release)','App signing, keystore & certificates setup','Store listing: title, description, keywords (ASO)','App icon, feature graphic & screenshot preparation','Privacy policy, content rating & compliance','Handling review rejections and resubmissions','Post-launch monitoring & update releases']),
  ];

  static const skillGroups = [
    SkillGroup('Android Development','📱',['Kotlin','Java','Jetpack Compose','XML Layouts','Android SDK','MVVM','Room DB','SQLite','Retrofit']),
    SkillGroup('Flutter & Cross Platform','🦋',['Flutter','Dart','Responsive UI','Provider','Riverpod','BLoC','Google Maps','Socket.IO','FCM']),
    SkillGroup('Backend Development','⚙️',['Node.js','Express.js','MongoDB','Mongoose','REST APIs','Socket.IO','JWT Auth','Firebase Auth','Cloud Functions']),
    SkillGroup('AI & Integrations','🤖',['OpenAI API','Gemini API','ML Kit','AI Chatbot','Smart Recommendations','Image Recognition','NLP Features']),
    SkillGroup('Tools & Databases','🛠️',['Git & GitHub','Android Studio','VS Code','Firebase Console','Postman','Gradle','MySQL','Firestore']),
    SkillGroup('App Store Publishing','🏪',['Google Play Console','Apple App Store Connect','TestFlight (Beta)','App Signing & Keystore','ASO (App Store Optimisation)','Privacy Policy & Compliance','Content Rating (PEGI/ESRB)','Release Management']),
  ];

  static const softSkills = [
    SoftSkill('Client Communication','Clear, timely updates with clients on Upwork and beyond — milestones, feedback loops and transparency.','💬'),
    SoftSkill('Problem Solving','I break complex technical challenges into clean, manageable solutions — from architecture to debugging.','🧩'),
    SoftSkill('Time Management','Delivering on deadlines is non-negotiable. I plan sprints, prioritise tasks and ship on time, every time.','⏱️'),
    SoftSkill('Attention to Detail','Pixel-perfect UI, clean code and thorough testing — I care about the small things that make the big difference.','🔍'),
    SoftSkill('Continuous Learning','Tech moves fast. I stay current with Flutter updates, AI integrations and backend patterns.','📚'),
    SoftSkill('Team Collaboration','Collaborative and adaptable — experience working in teams during internship and live client projects.','🤝'),
  ];

  static const projects = [
    Project(
      title:'Trasingo', subtitle:'Shipment Management System',
      problem:'Logistics companies had no real-time driver visibility — manual tracking, delayed updates, poor client communication.',
      solution:'Two Flutter apps (Client & Driver) with live Socket.IO location tracking, Node.js REST API and MongoDB backend.',
      technologies:['Flutter (Dart)','Node.js','Express.js','MongoDB','Socket.IO','Firebase Auth','Firebase FCM','Google Maps'],
      features:['Real-time driver location on map','Client: create shipments & track live','Driver: accept, update & complete deliveries','Push notifications for status changes','Secure Firebase Authentication','Scalable REST API','Payment flow integration'],
      yourRole:'Full Stack Developer — Designed both Flutter apps and the complete Node.js backend. Handled architecture, Socket.IO real-time integration, Firebase setup and Upwork milestone delivery.',
      tags:['Flutter','Node.js','MongoDB','Socket.IO','Firebase'],
      repoUrl:'https://github.com/hamayunsaeed48', liveUrl:'https://github.com/hamayunsaeed48',
      gradient:[0xFFCDA876,0xFF8B6F47], accentColor:[0xFFCDA876,0xFFFFD080],
      screenshots:[
        ProjectScreenshot('assets/projects/trasingo/transigo_1.png','Client Dashboard'),
        ProjectScreenshot('assets/projects/trasingo/transigo_2.png','Live Tracking Map'),
        ProjectScreenshot('assets/projects/trasingo/transigo_3.png','Driver App'),
        ProjectScreenshot('assets/projects/trasingo/transigo_4.png','Shipment Details'),
      ], demoVideoPath:'assets/projects/trasingo/demo.mp4',
    ),
    Project(
      title:'Nawabi Dinest Café', subtitle:'Full-Stack Food Ordering & Table Booking',
      problem:'A restaurant relied on phone orders and manual reservations — errors, long wait times and overworked staff.',
      solution:'Complete ecosystem: Android customer app + web admin panel + Node.js backend for real-time orders and bookings.',
      technologies:['Kotlin','Jetpack Compose','Node.js','MongoDB','Firebase Auth','Firebase FCM','JavaScript (Admin Panel)','REST API'],
      features:['Browse menu with categories','Real-time table booking','Live order status updates','Admin panel: manage orders, menu & bookings','Push notifications (FCM)','Secure Firebase Authentication','MVVM architecture'],
      yourRole:'Full Stack Developer — Built the Android app in Kotlin + Jetpack Compose, Node.js + MongoDB backend, JavaScript admin panel, and wired Firebase Auth & FCM end-to-end.',
      tags:['Kotlin','Jetpack Compose','Node.js','MongoDB','Firebase'],
      repoUrl:'https://github.com/hamayunsaeed48', liveUrl:'https://github.com/hamayunsaeed48',
      gradient:[0xFF6FA8AD,0xFF3F6F73], accentColor:[0xFF6FA8AD,0xFFA8DDE1],
      screenshots:[
        ProjectScreenshot('assets/projects/nawabi/screen1.png','Menu Screen'),
        ProjectScreenshot('assets/projects/nawabi/screen2.png','Table Booking'),
        ProjectScreenshot('assets/projects/nawabi/screen3.png','Order Tracking'),
        ProjectScreenshot('assets/projects/nawabi/screen4.png','Admin Panel'),
      ], demoVideoPath:'assets/projects/nawabi/demo.mp4',
    ),
    Project(
      title:'Real-Time Chat App', subtitle:'One-to-One Messaging with Live Updates',
      problem:'Users needed fast, reliable messaging with instant delivery, no login friction and push alerts.',
      solution:'Kotlin + Jetpack Compose chat app powered by Firebase Firestore live sync, Auth and FCM push notifications.',
      technologies:['Kotlin','Jetpack Compose','Firebase Firestore','Firebase Auth','Firebase FCM','MVVM'],
      features:['Real-time one-to-one messaging','Firebase Auth login & registration','Push notifications for new messages','Message read receipts','Modern chat UI with Jetpack Compose','Offline message caching'],
      yourRole:'Sole Developer — Designed UI, implemented Firestore real-time listeners, Firebase Auth login flow and FCM notification handling.',
      tags:['Kotlin','Jetpack Compose','Firebase','Firestore','FCM'],
      repoUrl:'https://github.com/hamayunsaeed48', liveUrl:'https://github.com/hamayunsaeed48',
      gradient:[0xFFB388A4,0xFF6E4A60], accentColor:[0xFFB388A4,0xFFE4C4D8],
      screenshots:[
        ProjectScreenshot('assets/projects/chat/screen1.png','Chat List'),
        ProjectScreenshot('assets/projects/chat/screen2.png','Conversation View'),
        ProjectScreenshot('assets/projects/chat/screen3.png','Login Screen'),
      ], demoVideoPath:'assets/projects/chat/demo.mp4',
    ),
    Project(
      title:'Lost & Found App', subtitle:'Community Item Recovery Platform',
      problem:'People losing items had no structured digital platform — just scattered social media posts with no contact or search system.',
      solution:'Community platform to post lost/found items with photos, location, date — shared feed, direct messaging and reward system.',
      technologies:['Kotlin','Android','Node.js','MongoDB','REST API','Firebase Auth','Image Upload'],
      features:['Post lost/found with photo, location & date','Shared community feed with filters','Direct messaging between users','Reward posting system','Secure Node.js + MongoDB backend','Firebase Authentication'],
      yourRole:'Full Stack Developer — Built Android frontend, Node.js REST API, MongoDB schema, image upload system and the messaging feature.',
      tags:['Kotlin','Android','Node.js','MongoDB','REST API'],
      repoUrl:'https://github.com/hamayunsaeed48', liveUrl:'https://github.com/hamayunsaeed48',
      gradient:[0xFF7D9D7C,0xFF44604A], accentColor:[0xFF7D9D7C,0xFFB8D9B7],
      screenshots:[
        ProjectScreenshot('assets/projects/lostfound/screen1.png','Home Feed'),
        ProjectScreenshot('assets/projects/lostfound/screen2.png','Post Item'),
        ProjectScreenshot('assets/projects/lostfound/screen3.png','Item Detail'),
        ProjectScreenshot('assets/projects/lostfound/screen4.png','Messages'),
      ], demoVideoPath:'assets/projects/lostfound/demo.mp4',
    ),
    Project(
      title:'News Hub', subtitle:'Modern News App with Offline Reading',
      problem:'Existing news apps were cluttered, slow and lacked offline reading or easy category filtering.',
      solution:'Clean, fast news app with real-time API news, category filtering and Room Database for offline saved articles.',
      technologies:['Kotlin','Jetpack Compose','MVVM','Retrofit','Room Database','NewsAPI','Coroutines'],
      features:['Real-time news from multiple sources','Category-based filtering','Save favourites for offline reading','MVVM with Retrofit','Jetpack Compose UI with article cards','Search across headlines'],
      yourRole:'Sole Developer — Integrated NewsAPI, implemented MVVM with Retrofit, built the Room Database offline layer and designed the Jetpack Compose UI.',
      tags:['Kotlin','Jetpack Compose','MVVM','Room DB','REST API'],
      repoUrl:'https://github.com/hamayunsaeed48', liveUrl:'https://github.com/hamayunsaeed48',
      gradient:[0xFF7A8FAD,0xFF3F5473], accentColor:[0xFF7A8FAD,0xFFB4C8E0],
      screenshots:[
        ProjectScreenshot('assets/projects/newshub/screen1.png','Home Feed'),
        ProjectScreenshot('assets/projects/newshub/screen2.png','Article Detail'),
        ProjectScreenshot('assets/projects/newshub/screen3.png','Category Filter'),
        ProjectScreenshot('assets/projects/newshub/screen4.png','Saved Articles'),
      ], demoVideoPath:'assets/projects/newshub/demo.mp4',
    ),
    Project(
      title:'Kids Learning Apps', subtitle:'Educational Suite — Final Year Project',
      problem:'Young children lacked engaging, offline-capable apps for foundational learning that parents could trust.',
      solution:'Three interactive Android apps with voice support, animations and quizzes — alphabet, poems and clock reading.',
      technologies:['Kotlin','Android','XML','Firebase Auth','SQLite','Text-to-Speech API','Animation APIs'],
      features:['A–Z Alphabet App with voice & animations','Poem App with rhythm, Firebase login & quizzes','Clock App with analog quizzes (Easy/Med/Hard)','A–Z object quizzes (A for Apple)','Offline-friendly with SQLite profiles','Kid-safe colourful UI'],
      yourRole:'Sole Developer (Final Year Project) — Designed and built all three apps including UI, TTS integration, quiz logic, Firebase setup and local database for progress tracking.',
      tags:['Android','Kotlin','Firebase','Education','FYP'],
      repoUrl:'https://github.com/hamayunsaeed48', liveUrl:'https://github.com/hamayunsaeed48',
      gradient:[0xFFAD8A7A,0xFF73503F], accentColor:[0xFFAD8A7A,0xFFDFBDAF],
      screenshots:[
        ProjectScreenshot('assets/projects/kids/screen1.png','Alphabet App'),
        ProjectScreenshot('assets/projects/kids/screen2.png','Poem App'),
        ProjectScreenshot('assets/projects/kids/screen3.png','Clock Quiz'),
        ProjectScreenshot('assets/projects/kids/screen4.png','Progress Screen'),
      ], demoVideoPath:'assets/projects/kids/demo.mp4',
    ),
  ];

  static const experiences = [
    Experience(
      role:'Freelance Full Stack Mobile App Developer',
      org:'Upwork & Fiverr',
      duration:'Mar 2025 — Present',
      location:'Remote',
      points:[
        'Building Trasingo — a two-app Flutter shipment management system (Client & Driver) for a live Upwork client.',
        'Implementing real-time driver location tracking using Socket.IO and Google Maps.',
        'Building and maintaining scalable RESTful APIs with Node.js, Express and MongoDB.',
        'Integrating Firebase Authentication and Cloud Messaging for secure login and push notifications.',
        'Developed Puck Reward Game — a mobile gaming application for a Fiverr client, implementing engaging gameplay features, reward systems, and smooth user interactions.',
        'Collaborating with international clients across Upwork and Fiverr, delivering projects through clear communication, milestone-based development, and timely updates.',
      ],
    ),
    Experience(
      role:'Android & Backend Developer', org:'Internee.pk',
      duration:'June 2024 — August 2024', location:'Karachi, Pakistan',
      points:[
        'Built Android apps using Kotlin and Jetpack Compose with MVVM architecture.',
        'Integrated REST APIs using Retrofit for secure, real-time data operations.',
        'Designed and implemented backend APIs using Node.js, Express.js and MongoDB.',
        'Implemented Firebase Authentication and Cloud Messaging for push notifications.',
      ],
    ),
  ];

  static const education = [
    ('BS Computer Science','The Islamia University of Bahawalpur','2021 — 2025'),
    ('FSc Pre-Engineering','Govt. Sadiq Egerton College Bahawalpur','2018 — 2020'),
    ('Matriculation','Govt Higher Secondary School 319/H.R','2016 — 2018'),
  ];
}

class ApiUrlsConstants {
  // static const baseUrl = 'http://localhost:3000/proj/';
  static const baseUrl = 'https://poodle-lasting-tadpole.ngrok-free.app/proj/';
  // static const baseUrl = 'https://httpstat.us/500/';
  // ngrok http --url=poodle-lasting-tadpole.ngrok-free.app 80
  // static const baseUrl = 'https://dummyjson.com/';
  // static const baseUrl = 'https://newsapi.org/v2/';

  static const socketUrl = 'https://poodle-lasting-tadpole.ngrok-free.app/chat';
  static const socketPath = '/proj/socket.io';

  static const loginUrl = 'auth/login';
  static const registerUrl = 'auth/signup';
  static const logoutUrl = 'auth/logout';

  static const userUrl = 'users';
  static const userProfileUrl = 'users/profile';

  // NEWS API
  static const newsApiKey = 'd82707d92eff4070ae174f12b2b1c156';
  static const newsEverything = 'everything';
  static const dummyPosts = 'posts';
  static const searchDummyPosts = 'posts/search';
  static const dummyPostTags = 'posts/tags';
  static const dummyPostByTag = 'posts/tag'; //:tag

  // 'https://dummyjson.com/posts/tag/life'

  // CHAT MESSAGING
  static const fetchPreviousChatMessages = 'posts';

  static const List<String> publicUrls = [
    // List of public URLs that don't require authentication
    loginUrl,
    registerUrl,
    newsEverything,
    dummyPosts,
    searchDummyPosts,
  ];

  static const List<String> newsApiRoutes = [
    newsEverything,
  ];
}

class MyConfig {
  /// [Database Config]
  static const String SUPABASE_URL = "https://gnzbazupauehvgujkjqm.supabase.co/rest/v1/";
  static const String SUPABASE_API =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNTgyNTgxOSwiZXhwIjoxOTQxNDAxODE5fQ.t_FbOyTXlgQ_ViwPul9Oo8MxuQHlPUjG-N_WV4U4zVE';

  /// [Table Names]
  static const categoryTableName = 'category_categorymodel';
  static const articalTableName = 'articals_articalmodel?draft=eq.false&select=*,category_categorymodel(*)';

  /// [Urls]
  static const baseImageUrl = 'https://res.cloudinary.com/kevin420/image/upload/v1/';
}

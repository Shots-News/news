import 'package:supabase/supabase.dart';
import 'package:news/constant/config.dart';

final SupabaseClient supabase = SupabaseClient(MyConfig.SUPABASE_URL, MyConfig.SUPABASE_API);

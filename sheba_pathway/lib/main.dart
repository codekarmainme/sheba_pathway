import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheba_pathway/bloc/auth_bloc/login/login_bloc.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signup/signup_bloc.dart';
import 'package:sheba_pathway/bloc/current_location/current_location_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/cost_model/cost_model_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/location_selection/location_selection_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/mapping_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/stream_position/stream_position_bloc.dart';
import 'package:sheba_pathway/bloc/payment_bloc/payment_blocs.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/provider/mapping_provider.dart';
import 'package:sheba_pathway/repository/auth_repository.dart';
import 'package:sheba_pathway/repository/mapping_repository.dart';
import 'package:sheba_pathway/repository/payment_repository.dart';
import 'package:sheba_pathway/repository/travel_plans_repository.dart';
import 'package:sheba_pathway/screens/added_travel_plans.dart';
import 'package:sheba_pathway/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:sheba_pathway/provider/hotel_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/fetchlocationsearchresult/bloc/fetchlocationsearchresult_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sheba_pathway/bloc/travel_plans_bloc/travel_plans_bloc.dart';
import 'package:sheba_pathway/repository/hotel_picker_repository.dart';
import 'package:sheba_pathway/bloc/hotel_picker_bloc/hotel_picker_bloc.dart';
import 'package:chapa_unofficial/chapa_unofficial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: 'assets/.env');
  Chapa.configure(privateKey: "CHASECK_TEST-lgM28ptmhS7NkrDSb1dx89j5YNBKRC72");

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MappingProvider()),
    ChangeNotifierProvider(create: (_) => HotelProvider())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = AuthRepository();
    final MappingRepository mappingRepository = MappingRepository();
    final PaymentRepository paymentRepository = PaymentRepository();
    final TravelPlansRepository travelPlansRepository = TravelPlansRepository();
    final HotelPickerRepository hotelPickerRepository = HotelPickerRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc(authRepository)),
        BlocProvider(create: (context) => LoginBloc(authRepository)),
        BlocProvider(
            create: (context) =>
                CurrentLocationBloc(mappingRepository: mappingRepository)),
        BlocProvider(
            create: (context) =>
                FetchlocationsearchresultBloc(mappingRepository)),
        BlocProvider(create: (context) => LocationSelectionBloc()),
        BlocProvider(create: (context) => CostModelBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => MappingBloc(mappingRepository)),
        BlocProvider(
          create: (context) =>
              PaymentBloc(paymentRepository: paymentRepository),
        ),
        BlocProvider(
          create: (context) => TravelPlansBloc(travelPlansRepository),
        ),
        BlocProvider(
          create: (_) => HotelPickerBloc(hotelPickerRepository),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('am'),
          Locale('es'),
          Locale('ar'),
        ],
        locale: _locale,
        title: 'Sheba Pathway',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          textTheme: GoogleFonts.soraTextTheme(),
          useMaterial3: true,
        ),
        routes: {
          '/added_travel_plans': (context) => AddedTravelPlans(),
        },
        home: LoginScreen(),
      ),
    );
  }
}

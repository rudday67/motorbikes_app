import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorbikes_app/components/auth_wrapper.dart';
import 'package:motorbikes_app/cubit/auth/auth_cubit.dart';
import 'package:motorbikes_app/cubit/balance/balance_cubit.dart';
import "package:motorbikes_app/cubit/counter_cubit.dart";
import 'package:motorbikes_app/screens/home_screen.dart';
import 'package:motorbikes_app/screens/news_screen.dart';
import 'package:motorbikes_app/screens/routes/BalanceScreen/balance_screen.dart';
import 'package:motorbikes_app/screens/routes/BooksScreen/books_screen.dart';
import 'package:motorbikes_app/screens/routes/CounterScreen/counter_screen.dart';
import 'package:motorbikes_app/screens/routes/DatasScreen/datas_screen.dart';
import 'package:motorbikes_app/screens/routes/FormScreen/form_screen.dart';
import 'package:motorbikes_app/screens/routes/SecondScreen/custom_screen.dart';
import 'package:motorbikes_app/screens/routes/SecondScreen/second_screen.dart';
import 'package:motorbikes_app/screens/routes/SpendingScreen/spending_screen.dart';
import 'package:motorbikes_app/screens/routes/WelcomeScreen/welcome_screen.dart';
import 'package:motorbikes_app/screens/profile_screen.dart';
import 'package:motorbikes_app/screens/login_screen.dart'; // Import your login screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CounterCubit>(create: (context) => CounterCubit()),
          BlocProvider<BalanceCubit>(create: (context) => BalanceCubit()),
          BlocProvider<AuthCubit>(create: (context) => AuthCubit())
        ],
      child: MaterialApp(
        title: 'Flutter Demo', 
        theme: ThemeData(
          primarySwatch: Colors.blue, 
        ),
        initialRoute: '/login', // Set the initial route to LoginScreen
        routes: {
          // '/':(context) => const MyHomePage(title: 'Home Screen'),
          // // '/login-screen':(context) => const LoginScreen(),
          '/balance-scceen':(context) => const AuthWrapper(child: BalanceScreen()),
          '/spanding-screen':(context) => const AuthWrapper(child: SpendingScreen()),
          '/login': (context) => LoginScreen(),
          '/home': (context) => const MyHomePage(title: 'Home Screen'),
          '/second-screen': (context) => const SecondScreen(),
          '/custom-screen': (context) => const CustomScreen(),
          '/news-screen': (context) => const NewsScreen(),
          '/books-screen': (context) => const BooksScreen(),
          '/form-screen': (context) => const FormScreen(),
          '/datas-screen': (context) => const DatasScreen(),
          '/counter-screen': (context) => const CounterScreen(),
          '/welcome-screen': (context) => const CounterScreen(),
          '/balance-screen': (context) => const BalanceScreen(),
          '/spending-screen': (context) => const SpendingScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const WelcomeScreen(),
    const ProfileScreen(),
  ];

  final List<String> _appBarTitles = const [
    'Home',
    'Settings',
    'Profile',
  ]; // List of titles corresponding to each screen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigateAndCloseDrawer(BuildContext context, String routeName) {
    if (Scaffold.of(context).isDrawerOpen) {
      Navigator.pop(context); // Close the drawer first
    }
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            listTilePush(context, 'News Screen', '/news-screen'),
            listTilePush(context, 'Datas Screen', '/datas-screen'),
            listTilePush(context, 'Counter Screen', '/counter-screen'),
            listTilePush(context, 'Balance Screen', '/balance-screen'),
            listTilePush(context, 'Spending Screen', '/spending-screen'),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  ListTile listTilePush(
      BuildContext context, String screenName, String routesname) {
    return ListTile(
      title: Text(screenName),
      selected: _selectedIndex == 2,
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, routesname);
      },
    );
  }
}

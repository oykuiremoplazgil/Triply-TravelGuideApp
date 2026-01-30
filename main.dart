import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Guide App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignUpPage(),
    );
  }
}

class LoginSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        title: Text('Welcome to Triply', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'lib/image/Triply.jpg',
                height: 340,
                width: 400,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 200),
                Text(
                  'Welcome to the Triply!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    shadowColor: Colors.teal.shade300,
                    textStyle: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white), // Yazı rengini beyaz yap
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    shadowColor: Colors.teal.shade300,
                    textStyle: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white), // Yazı rengini beyaz yap
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AccountManager accountManager = AccountManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Email and Password are required!')),
                      );
                      return;
                    }

                    bool success = await accountManager.login(email, password);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login Successful')),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MenuPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid Email or Password')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AccountManager accountManager = AccountManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    'Create a New Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    Account newAccount = Account(
                      username: usernameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    await accountManager.saveAccount(newAccount);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Account Registered')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.blueGrey.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Center(
                child: Text(
                  'TRIPLY',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildMenuButton(
                        context,
                        icon: Icons.favorite_border,
                        label: 'Favorites',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritesPage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 25),
                      _buildMenuButton(
                        context,
                        icon: Icons.explore_outlined,
                        label: 'Discover New Places',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CountryCitySelection(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 25),
                      _buildMenuButton(
                        context,
                        icon: Icons.account_circle_outlined,
                        label: 'Account',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.cyan.shade700, // Updated color for a modern touch
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35), // Increased roundness
          ),
          elevation: 10,
          padding: EdgeInsets.symmetric(vertical: 22),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32, // Slightly increased icon size
            ),
            SizedBox(width: 18),
            Text(
              label,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2, // Added letter spacing for a clean look
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BasePage extends StatelessWidget {
  final Widget child;

  BasePage({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritesPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuPage()),
            );
          }
        },
      ),
    );
  }
}

class Account {
  String username;
  String email;
  String password;

  Account({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }
}

class AccountManager {
  Future<void> saveAccount(Account account) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', account.email);
    prefs.setString('user_password', account.password);
  }

  Future<Account?> getAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email');
    final password = prefs.getString('user_password');

    if (email != null && password != null) {
      return Account(username: '', email: email, password: password);
    }
    return null;
  }

  Future<bool> login(String email, String password) async {
    Account? account = await getAccount();
    if (account != null && account.email == email && account.password == password) {
      return true;
    }
    return false;
  }
}

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String username = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('user_username') ?? 'Unknown User';
      email = prefs.getString('user_email') ?? 'No email found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              _buildInfoBox('Username', username),
              SizedBox(height: 20),
              _buildInfoBox('Email', email),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginSignUpPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Log Out',
                      style: TextStyle(color: Colors.white), // Yazı rengini beyaz yap
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoBox(String title, String value) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.teal.shade100,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Place> favoritePlaces = [];
  bool isLoading = true;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    FavoritesManager favoritesManager = FavoritesManager();
    List<Place> loadedFavorites = await favoritesManager.loadFavoritePlaces();
    setState(() {
      favoritePlaces = loadedFavorites;
      isLoading = false;
    });
  }

  Map<String, List<Place>> groupPlacesByCategory(List<Place> places) {
    Map<String, List<Place>> groupedPlaces = {};
    for (var place in places) {
      if (groupedPlaces[place.category] == null) {
        groupedPlaces[place.category] = [];
      }
      groupedPlaces[place.category]!.add(place);
    }
    return groupedPlaces;
  }

  Future<void> removeFavorite(Place place) async {
    FavoritesManager favoritesManager = FavoritesManager();
    await favoritesManager.removeFavoritePlace(place.name);
    setState(() {
      favoritePlaces.remove(place);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${place.name} removed from favorites')),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Place>> groupedFavorites = groupPlacesByCategory(favoritePlaces);

    return BasePage(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Your Favorite Places'),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : favoritePlaces.isEmpty
            ? Center(child: Text('No favorite places added yet.'))
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: groupedFavorites.keys.length,
                itemBuilder: (context, index) {
                  String category = groupedFavorites.keys.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = selectedCategory == category ? null : category;
                      });
                    },
                    child: Card(
                      elevation: 4,
                      color: Colors.teal[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (selectedCategory != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: groupedFavorites[selectedCategory!]!.length,
                    itemBuilder: (context, index) {
                      Place place = groupedFavorites[selectedCategory!]![index];
                      return ListTile(
                        title: Text(place.name),
                        subtitle: Text(place.category),
                        trailing: IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () => removeFavorite(place),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
class FavoritesManager {
  static const _key = 'favorite_places';

  Future<List<Place>> loadFavoritePlaces() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritePlacesData = prefs.getStringList(_key) ?? [];

    return favoritePlacesData.map((e) => Place.fromJson(jsonDecode(e))).toList();
  }

  Future<void> removeFavoritePlace(String placeName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritePlacesData = prefs.getStringList(_key) ?? [];

    favoritePlacesData.removeWhere((e) => jsonDecode(e)['name'] == placeName);

    await prefs.setStringList(_key, favoritePlacesData);
  }

  Future<void> addFavoritePlace(Place place) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritePlacesData = prefs.getStringList(_key) ?? [];

    favoritePlacesData.add(jsonEncode(place.toJson()));

    await prefs.setStringList(_key, favoritePlacesData);
  }
}

class Place {
  final String name;
  final String category;

  Place({required this.name, required this.category});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
    };
  }
}

class CountryCitySelection extends StatefulWidget {
  @override
  _CountryCitySelectionState createState() => _CountryCitySelectionState();
}

class _CountryCitySelectionState extends State<CountryCitySelection> {
  String selectedCountry = '';
  String selectedCity = '';
  String customCity = '';

  List<String> countries = ['Turkey', 'USA', 'Italy'];
  List<String> cities = [];

  void updateCities(String country) {
    if (country == 'Turkey') {
      cities = ['Istanbul', 'Ankara', 'Izmir', 'Antalya', 'Sivas', 'Aydın', 'Bursa'];
    } else if (country == 'USA') {
      cities = ['New York', 'Los Angeles', 'Chicago', 'Miami', 'Las Vegas'];
    } else if (country == 'Italy') {
      cities = ['Rome', 'Milan', 'Venice', 'Florence', 'Naples'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Select Country and City',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/image/selectcountry.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flag, color: Colors.white, size: 30),
                        SizedBox(width: 10),
                        Text(
                          'Select Country',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Country',
                          style: TextStyle(fontSize: 22, color:Colors.white),
                        ),
                        value: selectedCountry.isEmpty ? null : selectedCountry,
                        underline: SizedBox(),
                        onChanged: (String? newCountry) {
                          setState(() {
                            selectedCountry = newCountry!;
                            selectedCity = '';
                            customCity = '';
                            updateCities(newCountry);
                          });
                        },
                        items: countries.map((String country) {
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(
                              country,
                              style: TextStyle(fontSize: 22),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/image/selectcity.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_city, color: Colors.white, size: 30),
                        SizedBox(width: 10),
                        Text(
                          'Select City',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select City',
                          style: TextStyle(fontSize: 22, color:Colors.white),
                        ),
                        value: selectedCity.isEmpty ? null : selectedCity,
                        underline: SizedBox(),
                        onChanged: (String? newCity) {
                          setState(() {
                            selectedCity = newCity!;
                            customCity = '';
                          });
                        },
                        items: cities.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(
                              city,
                              style: TextStyle(fontSize: 22),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/image/entercity.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.edit_location_alt, color: Colors.white, size: 30),
                        SizedBox(width: 10),
                        Text(
                          'Enter City Name',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          customCity = value;
                          selectedCity = '';
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'You can write the city',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (selectedCity.isNotEmpty || customCity.isNotEmpty)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String cityToNavigate = customCity.isNotEmpty ? customCity : selectedCity;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategorySelection(city: cityToNavigate),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
class CategorySelection extends StatefulWidget {
  final String city;

  CategorySelection({required this.city});

  @override
  _CategorySelectionState createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  final List<String> categories = [
    'Food and Drink',
    'Accommodation',
    'Historical and Cultural',
    'Shopping'
  ];

  final List<String> categoryImages = [
    'lib/image/foodanddrink.jpeg',
    'lib/image/accomodation.jpeg',
    'lib/image/culturalhistorical.jpeg',
    'lib/image/shopping.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return BasePage(
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(
              'Select Category for ${widget.city}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              double buttonHeight = constraints.maxHeight / 2;
              double buttonWidth = constraints.maxWidth / 2;
              return Column(
                children: [
                  Row(
                    children: [
                      buildCategoryButton(categories[0], categoryImages[0], buttonWidth, buttonHeight),
                      buildCategoryButton(categories[1], categoryImages[1], buttonWidth, buttonHeight),
                    ],
                  ),
                  Row(
                    children: [
                      buildCategoryButton(categories[2], categoryImages[2], buttonWidth, buttonHeight),
                      buildCategoryButton(categories[3], categoryImages[3], buttonWidth, buttonHeight),
                    ],
                  ),
                ],
              );
            },
          ),
        )
    );
  }Widget buildCategoryButton(String category, String imagePath, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlacesList(
                city: widget.city,
                category: category,
              ),
            ),
          );
        },
        child: Center(
          child: Text(
            category,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
class PlacesList extends StatefulWidget {
  final String city;
  final String category;

  PlacesList({required this.city, required this.category});

  @override
  _PlacesListState createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {
  bool isLoading = false;
  List<Map<String, dynamic>> places = [];
  List<String> selectedPlaces = [];
  final String apiKey = 'x';

  @override
  void initState() {
    super.initState();
    fetchPlaces();
  }
  Future<void> fetchPlaces() async {
    setState(() {
      isLoading = true;
    });

    final url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=${Uri.encodeComponent(widget.category)}+in+${Uri.encodeComponent(widget.city)}&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          List<Map<String, dynamic>> basicPlaces = List<Map<String, dynamic>>.from(data['results'].map((place) {
            String? photoReference = place['photos'] != null && place['photos'].isNotEmpty
                ? place['photos'][0]['photo_reference']
                : null;

            String? photoUrl = photoReference != null
                ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$photoReference&key=$apiKey'
                : null;

            return {
              'name': place['name'].toString(),
              'address': place['formatted_address']?.toString() ?? 'No address available',
              'rating': place['rating']?.toString() ?? 'No rating available',
              'place_id': place['place_id']?.toString() ?? '',
              'photo_url': photoUrl ?? 'https://via.placeholder.com/400',
            };
          }));

          List<Map<String, dynamic>> detailedPlaces = [];
          for (var place in basicPlaces) {
            if (place['place_id'] != null && place['place_id']!.isNotEmpty) {
              final details = await fetchPlaceDetails(place['place_id']!);
              detailedPlaces.add({
                'name': place['name']!,
                'address': place['address']!,
                'rating': place['rating']!,
                'photo_url': place['photo_url']!,
                'phone': details['phone'] ?? 'No phone available',
                'reviews': details['reviews'] ?? 'No reviews available',
                'price_level': details['price_level'] ?? 'No price information',
                'reviewList': details['reviewList'] ?? [],
                'reviews_count': details['reviews_count'] ?? 0,
              });
            }
          }

          setState(() {
            places = detailedPlaces;
            isLoading = false;
          });
        } else {
          setState(() {
            places = [];
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Request failed: $e');
    }
  }
  Future<Map<String, dynamic>> fetchPlaceDetails(String placeId) async {
    final detailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=formatted_phone_number,price_level,user_ratings_total,reviews&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(detailsUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = data['result'];

        final List<dynamic>? reviewList = result['reviews'];

        List<Map<String, String>> reviews = [];
        if (reviewList != null && reviewList.isNotEmpty) {
          reviews = reviewList.map((review) {
            return {
              'author_name': review['author_name']?.toString() ?? 'Anonymous',
              'text': review['text']?.toString() ?? 'No review text available',
              'profile_photo_url': review['profile_photo_url']?.toString() ?? '',
            };
          }).toList();
        }

        return {
          'phone': result['formatted_phone_number']?.toString() ?? 'No phone available',
          'reviews': result['user_ratings_total']?.toString() ?? 'No reviews available',
          'price_level': result['price_level']?.toString() ?? 'No price information',
          'reviewList': reviews.isNotEmpty ? reviews : [],
          'reviews_count': result['user_ratings_total'] ?? 0,
        };
      } else {
        print('Details API error: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Details API request failed: $e');
      return {};
    }
  }

  void sortPlacesByRating() {
    setState(() {
      places.sort((a, b) {
        double ratingA = double.tryParse(a['rating'] ?? '0') ?? 0;
        double ratingB = double.tryParse(b['rating'] ?? '0') ?? 0;
        return ratingB.compareTo(ratingA);
      });
    });
  }

  void sortPlacesByRatingLowToHigh() {
    setState(() {
      places.sort((a, b) {
        double ratingA = double.tryParse(a['rating'] ?? '0') ?? 0;
        double ratingB = double.tryParse(b['rating'] ?? '0') ?? 0;
        return ratingA.compareTo(ratingB);
      });
    });
  }

  void sortPlacesByPriceHighToLow() {
    setState(() {
      places.sort((a, b) {
        double priceA = double.tryParse(a['price_level'] ?? '0') ?? 0;
        double priceB = double.tryParse(b['price_level'] ?? '0') ?? 0;
        return priceB.compareTo(priceA);
      });
    });
  }

  void sortPlacesByPriceLowToHigh() {
    setState(() {
      places.sort((a, b) {
        double priceA = double.tryParse(a['price_level'] ?? '0') ?? 0;
        double priceB = double.tryParse(b['price_level'] ?? '0') ?? 0;
        return priceA.compareTo(priceB);
      });
    });
  }

  void toggleSelection(String placeName) async {
    setState(() {
      if (selectedPlaces.contains(placeName)) {
        selectedPlaces.remove(placeName);
      } else {
        selectedPlaces.add(placeName);
      }
    });

    FavoritesManager favoritesManager = FavoritesManager();

    if (selectedPlaces.contains(placeName)) {
      await favoritesManager.addFavoritePlace(Place(name: placeName, category: widget.category));
      print("Added: $placeName");
    } else {
      await favoritesManager.removeFavoritePlace(placeName);
      print("Deleted: $placeName");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(
              'Places in ${widget.city} - ${widget.category}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Recommended') {
                  } else if (value == 'Rating High to Low') {
                    sortPlacesByRating();
                  } else if (value == 'Rating Low to High') {
                    sortPlacesByRatingLowToHigh();
                  } else if (value == 'Price High to Low') {
                    sortPlacesByPriceHighToLow();
                  } else if (value == 'Price Low to High') {
                    sortPlacesByPriceLowToHigh();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'Recommended',
                      child: Text('Recommended'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Price High to Low',
                      child: Text('Price High to Low'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Price Low to High',
                      child: Text('Price Low to High'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Rating High to Low',
                      child: Text('Rating High to Low'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Rating Low to High',
                      child: Text('Rating Low to High'),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: place['photo_url'] != null
                      ? Image.network(
                    place['photo_url']!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.image, size: 80),
                  title: Text(place['name']!),
                  subtitle: Text(place['address']!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: selectedPlaces.contains(place['name']),
                        onChanged: (bool? value) {
                          toggleSelection(place['name']!);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaceDetails(
                                name: place['name']!,
                                address: place['address']!,
                                rating: place['rating']!,
                                phone: place['phone']!,
                                reviews: place['reviews']!,
                                priceLevel: place['price_level']!,
                                reviewList: place['reviewList']!,
                                reviewsCount: place['reviews_count'],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}
class PlaceDetails extends StatelessWidget {
  final String name;
  final String address;
  final String rating;
  final String phone;
  final String reviews;
  final String priceLevel;
  final List<Map<String, String>> reviewList;
  final int reviewsCount;

  PlaceDetails({
    required this.name,
    required this.address,
    required this.rating,
    required this.phone,
    required this.reviews,
    required this.priceLevel,
    required this.reviewList,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(name),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address: $address',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Rating: $rating',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Phone: $phone',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Price Level: $priceLevel',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Reviews ($reviewsCount):',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: reviewList.length,
                    itemBuilder: (context, index) {
                      final review = reviewList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(review['profile_photo_url']!),
                        ),
                        title: Text(review['author_name']!),
                        subtitle: Text(review['text']!),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Tambahkan logika otentikasi di sini
                String username = usernameController.text;
                String password = passwordController.text;
                print('Username: $username, Password: $password');

                // Simulasi otentikasi sederhana
                if (username == 'user' && password == 'password') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AbsenPage(username)),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Login Gagal'),
                        content: Text('Username atau password salah.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class AbsenPage extends StatefulWidget {
  final String username;

  AbsenPage(this.username);

  @override
  _AbsenPageState createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  List<String> riwayatAbsen = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absen Mahasiswa'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Tambahkan logika absen di sini
            DateTime now = DateTime.now();
            String timestamp = now.toLocal().toString();

            // Simpan data absen ke variabel lokal
            riwayatAbsen.add('${widget.username} - $timestamp');

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Absensi Berhasil'),
                  content: Text('Absensi Anda telah berhasil dicatat.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Absen'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RiwayatAbsenPage(riwayatAbsen)),
          );
        },
        child: Icon(Icons.history),
      ),
    );
  }
}

class RiwayatAbsenPage extends StatelessWidget {
  final List<String> riwayatAbsen;

  RiwayatAbsenPage(this.riwayatAbsen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Absen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Riwayat Absen'),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: riwayatAbsen.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(riwayatAbsen[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

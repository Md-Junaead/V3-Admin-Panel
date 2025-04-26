// import 'package:admin_panel/screens/login/auth_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthViewModel>(context);
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 1200),
//           child: Padding(
//             padding: const EdgeInsets.all(40.0),
//             child: screenWidth < 800
//                 ? _buildMobileLayout(authProvider)
//                 : _buildDesktopLayout(authProvider),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDesktopLayout(AuthViewModel authProvider) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 2,
//           child: Padding(
//             padding: const EdgeInsets.all(40.0),
//             child: Image.asset(
//               'assets/logos/login_icon_logo.png',
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 3,
//           child: _buildLoginForm(authProvider),
//         ),
//       ],
//     );
//   }

//   Widget _buildMobileLayout(AuthViewModel authProvider) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Image.asset(
//             'assets/logos/login_icon_logo.png',
//             height: 250,
//           ),
//           _buildLoginForm(authProvider),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoginForm(AuthViewModel authProvider) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 500),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: _obscureText,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: const OutlineInputBorder(),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 16, horizontal: 20),
//                     suffixIcon: IconButton(
//                       icon: Icon(_obscureText
//                           ? Icons.visibility
//                           : Icons.visibility_off),
//                       onPressed: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 authProvider.isLoading
//                     ? const CircularProgressIndicator()
//                     : ElevatedButton(
//                         onPressed: () {
//                           authProvider.login(
//                             _emailController.text.trim(),
//                             _passwordController.text.trim(),
//                             false, // Hardcoded rememberMe value
//                             context,
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 18),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             side: const BorderSide(
//                               color: Colors.black,
//                               width: 1.0,
//                             ),
//                           ),
//                         ),
//                         child: const Text(
//                           'LOG IN',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Color(0xFF06426D),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                 if (authProvider.errorMessage != null)
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(authProvider.errorMessage!,
//                         style: const TextStyle(color: Colors.red)),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:admin_panel/screens/login/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: _buildLoginForm(authProvider),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(AuthViewModel authProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: 'Password',
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 30),
        authProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                // onPressed: () {
                //   authProvider.login(
                //     _emailController.text.trim(),
                //     _passwordController.text.trim(),
                //     false, // rememberMe is hardcoded for now
                //     context,
                //   );
                // },
                onPressed: () {
                  authProvider.login(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                    false, // Keep rememberMe hardcoded or add UI control
                    context,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                child: const Text(
                  'LOG IN',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF06426D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        if (authProvider.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              authProvider.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}

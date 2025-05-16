import 'package:flutter/material.dart';
import '../../services/auth_services.dart';
import '../view/SignUpLogin/login.dart';


class VerifyOtpPage extends StatefulWidget {
  final String email;
  const VerifyOtpPage({super.key, required this.email});

  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool loading = false;

  void _verifyAndResetPassword() async {
    final otp = otpController.text.trim();
    final newPassword = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if ([otp, newPassword, confirmPassword].any((field) => field.isEmpty)) {
      _showSnackbar("Please fill in all fields", Colors.red);
      return;
    }

    if (newPassword != confirmPassword) {
      _showSnackbar("Passwords do not match", Colors.red);
      return;
    }

    setState(() => loading = true);
    final result = await AuthService.verifyOtpAndResetPassword(
      email: widget.email,
      otp: otp,
      newPassword: newPassword,
    );
    setState(() => loading = false);

    if (result['success']) {
      _showSnackbar("Password reset successfully", Colors.green);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
      });
    } else {
      _showSnackbar(result['message'], Colors.red);
    }
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP"),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(otpController, "Enter OTP", Icons.numbers),
                const SizedBox(height: 15),
                _buildPasswordField(passwordController, "New Password", isPasswordVisible, () {
                  setState(() => isPasswordVisible = !isPasswordVisible);
                }),
                const SizedBox(height: 15),
                _buildPasswordField(confirmPasswordController, "Confirm Password", isConfirmPasswordVisible, () {
                  setState(() => isConfirmPasswordVisible = !isConfirmPasswordVisible);
                }),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: loading ? null : _verifyAndResetPassword,
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Reset Password", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildPasswordField(
      TextEditingController controller,
      String label,
      bool isVisible,
      VoidCallback toggle,
      ) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

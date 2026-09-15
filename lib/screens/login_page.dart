import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // fond gris foncé
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset("assets/logo.jpg", height: 40), // un seul logo
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("DeviceSpecs",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text("Profile",
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.person, color: Colors.white, size: 40),
              ],
            ),
            const SizedBox(height: 40),

            // Bloc centré
            Center(
              child: Column(
                children: const [
                  Icon(Icons.person_add_alt_1,
                      size: 70, color: Colors.white70),
                  SizedBox(height: 16),
                  Text("Créer un compte",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  SizedBox(
                    width: 300,
                    child: Text(
                      "Rejoignez DeviceSpecs pour analyser,\narchiver et exposer vos rapports matériels.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Boutons Créer un compte / Inscription
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Créer un compte",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Inscription",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Formulaire
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildField("Nom au complet", controller: _nameController),
                  const SizedBox(height: 18),
                  _buildField("Adresse email", controller: _emailController),
                  const SizedBox(height: 18),
                  _buildField("Mot de passe",
                      controller: _passwordController, obscure: true),
                  const SizedBox(height: 18),
                  _buildField("Confirmer le mot de passe",
                      controller: _confirmController, obscure: true),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Case à cocher
            CheckboxListTile(
              value: acceptTerms,
              onChanged: (val) => setState(() => acceptTerms = val ?? false),
              title: const Text(
                "Accepter les conditions générales et la politique de confidentialité",
                style: TextStyle(color: Colors.white70),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.grey[700],
              checkColor: Colors.white,
            ),
            const SizedBox(height: 28),

            // Bouton principal
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && acceptTerms) {
                  Navigator.pushReplacementNamed(context, "/home");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Créer mon compte",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 28),

            // Options externes centrées
            const Center(
              child: Text("ou s’inscrire avec",
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.g_mobiledata, color: Colors.white),
              label: const Text("Continuer avec Google",
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.code, color: Colors.white),
              label: const Text("Continuer avec GitHub",
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label,
      {TextEditingController? controller, bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[500]!),
        ),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? "Champ requis" : null,
    );
  }
}

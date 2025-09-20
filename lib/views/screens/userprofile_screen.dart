import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  //! Controllers
  final TextEditingController _userIdCtrl = TextEditingController();
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  //! Dispos
  @override
  void dispose() {
    _userIdCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  //! Roles
  String? _role;

  //! Obsucre Password
  bool _obscure = true;

  String? _req(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;

  String? _validateUserId(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    final n = int.tryParse(v.trim());
    if (n == null || n < 0) return 'Must be a non-negative integer';
    return null;
  }

  String? _validateEmail(String? v) {
    if (_req(v) != null) return 'Required';
    final s = v!.trim();
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s);
    return ok ? null : 'Invalid email';
  }

  String _hashPassword(String raw) {
    final bytes = utf8.encode(raw);
    final digest = sha256.convert(bytes);
    return digest.toString(); // hex
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate() || _role == null) {
      if (_role == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select a Role')));
      }
      return;
    }
    final data = {
      'UserID (PK)': _userIdCtrl.text.trim(),
      'FirstName': _firstNameCtrl.text.trim(),
      'LastName': _lastNameCtrl.text.trim(),
      'Email': _emailCtrl.text.trim(),
      'PhoneNumber': _phoneCtrl.text.trim(),
      'Address': _addressCtrl.text.trim(),
      'Role': _role!,
      'Password (hashed)': _hashPassword(_passwordCtrl.text),
    };

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('User Record'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SelectableText('${e.key}: ${e.value}'),
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.local_library_outlined),
        title: const Text('Henry Luce III Library - Users'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row 1: UserID, Role
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextFormField(
                            controller: _userIdCtrl,
                            decoration: const InputDecoration(
                              labelText: 'UserID (PK)',
                              hintText: 'e.g., 1001',
                            ),
                            keyboardType: TextInputType.number,
                            validator: _validateUserId,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: DropdownButtonFormField<String>(
                            initialValue: _role,
                            decoration: const InputDecoration(
                              labelText: 'Role',
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'Student',
                                child: Text('Student'),
                              ),
                              DropdownMenuItem(
                                value: 'Faculty',
                                child: Text('Faculty'),
                              ),
                              DropdownMenuItem(
                                value: 'Librarian',
                                child: Text('Librarian'),
                              ),
                            ],
                            onChanged: (v) => setState(() => _role = v),
                            validator: (_) => _role == null ? 'Required' : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Row 2: FirstName, LastName
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextFormField(
                            controller: _firstNameCtrl,
                            decoration: const InputDecoration(
                              labelText: 'FirstName',
                            ),
                            validator: _req,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            controller: _lastNameCtrl,
                            decoration: const InputDecoration(
                              labelText: 'LastName',
                            ),
                            validator: _req,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Email, Phone
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextFormField(
                            controller: _emailCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            controller: _phoneCtrl,
                            decoration: const InputDecoration(
                              labelText: 'PhoneNumber',
                            ),
                            keyboardType: TextInputType.phone,
                            validator: _req,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Address
                  TextFormField(
                    controller: _addressCtrl,
                    decoration: const InputDecoration(labelText: 'Address'),
                    validator: _req,
                    minLines: 1,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  // Password
                  TextFormField(
                    controller: _passwordCtrl,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: 'Password (will be hashed)',
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _obscure = !_obscure),
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    validator: (v) => (v == null || v.isEmpty)
                        ? 'Required'
                        : (v.length < 6 ? 'Min 6 chars' : null),
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submit,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Save & Preview in Dialog'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

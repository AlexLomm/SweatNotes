import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/services/firebase.dart';
import '../../../widgets/button.dart';
import '../../../widgets/display_name_field.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/layout.dart';
import '../../auth/services/auth_service.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  final _displayNameController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    final firebaseAuth = ref.read(firebaseAuthProvider);

    _displayNameController.text = firebaseAuth.currentUser!.displayName ?? '';
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);

    return Layout(
      centerTitle: false,
      leading: GoBackButton(onPressed: () => context.pop()),
      appBarTitle: Text(
        'Account',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            DisplayNameField(controller: _displayNameController),
            const SizedBox(height: 24.0),
            SizedBox(
              width: 94.0,
              child: Button(
                label: 'Update',
                isLoading: _isLoading,
                onPressed: () async {
                  setState(() => _isLoading = true);

                  await authService.updateDisplayName(_displayNameController.text);

                  if (mounted) setState(() => _isLoading = false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

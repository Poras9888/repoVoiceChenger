import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/ads/consent_manager.dart';
import '../../core/constants/app_dimensions.dart';
import '../screens/settings/settings_cubit.dart';
import '../screens/settings/settings_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _audioQuality = 'Medium';
  String _storageLocation = 'Internal';
  String _defaultEffect = 'Normal';
  bool _biometricLock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {},
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          children: [
            // Audio Quality
            Text(
              'Audio Settings',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppDimensions.spacing8),
            ListTile(
              title: const Text('Audio Quality'),
              trailing: DropdownButton<String>(
                value: _audioQuality,
                items: ['Low', 'Medium', 'High']
                    .map((q) => DropdownMenuItem(value: q, child: Text(q)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _audioQuality = value);
                    context.read<SettingsCubit>().setAudioQuality(value);
                  }
                },
              ),
            ),

            const Divider(),

            // Storage Location
            ListTile(
              title: const Text('Storage Location'),
              trailing: DropdownButton<String>(
                value: _storageLocation,
                items: ['Internal', 'SD Card']
                    .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _storageLocation = value);
                    context
                        .read<SettingsCubit>()
                        .setStorageLocation(value);
                  }
                },
              ),
            ),

            const Divider(),

            // Default Effect
            ListTile(
              title: const Text('Default Effect'),
              trailing: DropdownButton<String>(
                value: _defaultEffect,
                items: [
                  'Normal',
                  'Robot',
                  'Monster',
                  'Cave',
                  'Alien',
                ]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _defaultEffect = value);
                    context.read<SettingsCubit>().setDefaultEffect(value);
                  }
                },
              ),
            ),

            const Divider(),

            // Privacy & Security
            Text(
              'Privacy & Security',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppDimensions.spacing8),
            SwitchListTile(
              title: const Text('Biometric Lock'),
              value: _biometricLock,
              onChanged: (value) {
                setState(() => _biometricLock = value);
                context.read<SettingsCubit>().setBiometricLock(value);
              },
            ),

            ListTile(
              title: const Text('Ad Preferences'),
              trailing: const Icon(Icons.privacy_tip_outlined),
              onTap: () =>
                  ConsentManager.showPrivacyOptionsForm(context),
            ),

            const Divider(),

            // Links
            Text(
              'Information',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppDimensions.spacing8),
            ListTile(
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () async {
                const url = 'https://your-privacy-policy.com';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
            ListTile(
              title: const Text('Rate App'),
              trailing: const Icon(Icons.star),
              onTap: () async {
                const url =
                    'https://play.google.com/store/apps/details?id=com.voice.changer.sound.effects.recorder';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
            ListTile(
              title: const Text('Share App'),
              trailing: const Icon(Icons.share),
              onTap: () =>
                  Share.share('Check out Voice Changer & Sound Effects!'),
            ),

            const Divider(),

            // About
            ListTile(
              title: const Text('Version'),
              trailing: const Text('1.0.0'),
            ),
          ],
        ),
      ),
    );
  }
}

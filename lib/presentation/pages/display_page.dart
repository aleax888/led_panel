import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel/led_panel_bloc.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';
import 'package:led_panel/presentation/widgets/lock_display_button.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Full LED panel display page.
class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  bool _isDisplayLoading = true;
  bool _isDisplayLocked = false;

  @override
  void initState() {
    super.initState();
    _enterImmersiveLandscape();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedPanelBloc, LedPanelState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, _) {
            if (!didPop && !_isDisplayLocked) _handleBack();
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: _isDisplayLoading
                ? Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      // Display ----------------------------------------------
                      GestureDetector(
                        onTap: _isDisplayLocked ? null : _handleBack,
                        child: SizedBox.expand(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [LedPanel(config: state.config)],
                          ),
                        ),
                      ),

                      // Lock/Unlock button ----------------------------------------------
                      Positioned(
                        right: AppSpacing.xs,
                        top: AppSpacing.xs,
                        child: LockDisplayButton(
                          isLocked: _isDisplayLocked,
                          onPressed: _toggleDisplayLock,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Future<void> _enterImmersiveLandscape() async {
    setState(() => _isDisplayLoading = true);
    await Future.wait([
      SystemChrome.setEnabledSystemUIMode(.immersiveSticky),
      SystemChrome.setPreferredOrientations([.landscapeLeft, .landscapeRight]),
    ]).then((_) => setState(() => _isDisplayLoading = false));
  }

  Future<void> _exitImmersivePortrait() async {
    setState(() => _isDisplayLoading = true);
    await Future.wait([
      SystemChrome.setEnabledSystemUIMode(
        .manual,
        overlays: SystemUiOverlay.values,
      ),
      SystemChrome.setPreferredOrientations([.portraitUp, .portraitDown]),
    ]).then((_) => setState(() => _isDisplayLoading = false));
  }

  Future<void> _handleBack() async {
    await _exitImmersivePortrait();
    if (mounted) Navigator.of(context).pop();
  }

  void _toggleDisplayLock() {
    setState(() {
      _isDisplayLocked = !_isDisplayLocked;
    });
  }
}

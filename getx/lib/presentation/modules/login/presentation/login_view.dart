import 'package:kabar_app_getx/utils/extensions/centext_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../../config/enum/view_state.dart';
import '../../../../config/resources/app_colors.dart';
import '../../../widgets/image_screen.dart';
import '../../../widgets/loading_widget.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Get.put(LoginController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<LoginController>();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        elevation: 0,
      ),
      body: GetBuilder<LoginController>(
        builder: (c) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Again!',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 48,
                        color: context.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Welcome back you’ve been missed',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(24)),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username',
                                style: context.textTheme.bodySmall,
                              ),
                              const Padding(padding: EdgeInsets.all(4)),
                              TextFormField(
                                decoration: _decoration,
                                controller: _usernameController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username.';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(8)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                style: context.textTheme.bodySmall,
                              ),
                              const Padding(padding: EdgeInsets.all(4)),
                              TextFormField(
                                decoration: _decoration,
                                controller: _passwordController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password.';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters.';
                                  }
                                  return null;
                                },
                                obscureText: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                      c.state.viewState == ViewState.failed
                          ? Card(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              color: AppColors.instance.errorDark,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                width: context.sizeWidth,
                                child: Text(
                                  c.state.message,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodySmall
                                      ?.copyWith(color: Colors.white),
                                  // c.state.message,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    value: true,
                                    activeColor: context.primaryColor,
                                    onChanged: (value) {},
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(4)),
                                Text(
                                  'Remember me',
                                  style: context.textTheme.bodySmall,
                                )
                              ],
                            ),
                            Text(
                              'Forgot the password ?',
                              style: context.textTheme.bodySmall
                                  ?.copyWith(color: context.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(8)),
                      ElevatedButton(
                        onPressed: c.state.viewState == ViewState.loading
                            ? null
                            : () async {
                                await c.signIn();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SizedBox(
                            width: context.sizeWidth,
                            child: Center(
                              child: c.state.viewState == ViewState.loading
                                  ? const LoadingWidget()
                                  : Text(
                                      'Login',
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(4)),
                      Center(
                        child: Text(
                          'or continue with',
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(8)),
                      Row(
                        children: [
                          SizedBox(
                            width: (context.sizeWidth / 2) - 32,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(238, 241, 244, 1),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    const ImageScreen(
                                      'https://i.postimg.cc/Z538pzMv/fb.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    const Padding(padding: EdgeInsets.all(4)),
                                    Text(
                                      'Facebook',
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                        fontSize: 15,
                                        color: const Color.fromRGBO(
                                          102,
                                          112,
                                          128,
                                          1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(8)),
                          SizedBox(
                            width: (context.sizeWidth / 2) - 32,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(238, 241, 244, 1),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    const ImageScreen(
                                      'https://i.postimg.cc/V642jVNn/google.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    const Padding(padding: EdgeInsets.all(4)),
                                    Text(
                                      'Google',
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                        fontSize: 15,
                                        color: const Color.fromRGBO(
                                          102,
                                          112,
                                          128,
                                          1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(8)),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'don’t have an account',
                              style: context.textTheme.bodySmall,
                            ),
                            const Padding(padding: EdgeInsets.all(4)),
                            Text(
                              'Sign Up',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  InputDecoration get _decoration => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: context.textTheme.bodyMedium!.color!,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: context.primaryColor,
            width: 1.0,
          ),
        ),
        hintStyle: context.textTheme.bodyMedium
            ?.copyWith(color: context.disabledColor),
        filled: true,
        fillColor: context.canvasColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      );
}

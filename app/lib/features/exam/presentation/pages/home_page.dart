import 'package:exam_app/core/config/routes/named_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Quantidade de Números'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final quantity = int.tryParse(_controller.text);
                if (quantity != null && quantity > 0) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.pushNamed(NamedRoutes.randomNumbers, extra: quantity);
                  _controller.text = '';
                  return;
                }
                Fluttertoast.showToast(
                  msg: 'Preencha o campo com um número válido',
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              },
              child: const Text('Solicitar números'),
            ),
          ],
        ),
      ),
    );
  }
}

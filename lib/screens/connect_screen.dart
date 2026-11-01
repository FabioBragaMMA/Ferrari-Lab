import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  bool isConnecting = false;

  void _iniciarConexao() {
    setState(() {
      isConnecting = true;
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        // Garante que ocupe 100% da largura e altura da tela
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFB71C1C), Color(0xFF5D1010), Color(0xFF1A0505)],
            ),
          ),
          child: SafeArea(
            child: Center(
              // Centra todo o conteúdo perfeitamente no meio da tela inteira
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Centraliza os elementos horizontalmente
                  children: [
                    Icon(
                      isConnecting
                          ? Icons.bluetooth_searching
                          : Icons.bluetooth,
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      isConnecting
                          ? 'A procurar o veículo...'
                          : 'Conectar ao Veículo',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isConnecting
                          ? 'A estabelecer ligação segura via Bluetooth OBD-II com o Ferrari...'
                          : 'Certifica-te que a ignição do carro está ligada para estabelecer ligação.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 48),
                    if (isConnecting)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD35400),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: const Icon(Icons.bluetooth_connected, size: 28),
                          label: const Text(
                            'Conectar Agora',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _iniciarConexao,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

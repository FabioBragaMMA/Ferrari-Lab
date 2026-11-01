import 'package:flutter/material.dart';

class CarControlScreen extends StatefulWidget {
  final String carModel;
  final String carVersion;

  const CarControlScreen({
    super.key,
    required this.carModel,
    required this.carVersion,
  });

  @override
  State<CarControlScreen> createState() => _CarControlScreenState();
}

class _CarControlScreenState extends State<CarControlScreen> {
  bool isLocked = true;
  bool trunkOpen = false;
  bool sportMode = false;
  bool headlightsOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controlos: ${widget.carModel}'),
        backgroundColor: const Color(0xFFB71C1C),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                const Icon(Icons.bluetooth_connected, color: Colors.green),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Conectado a: ${widget.carModel} (${widget.carVersion})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Opções Avançadas do Carro',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          SwitchListTile(
            title: const Text('Trancar / Destrancar Portas'),
            subtitle: Text(
              isLocked ? 'Portas Trancadas' : 'Portas Destrancadas',
            ),
            secondary: Icon(
              isLocked ? Icons.lock : Icons.lock_open,
              color: const Color(0xFFB71C1C),
            ),
            value: isLocked,
            onChanged: (val) => setState(() => isLocked = val),
          ),
          const Divider(),

          SwitchListTile(
            title: const Text('Abrir Bagageira'),
            subtitle: Text(
              trunkOpen ? 'Bagageira Aberta' : 'Bagageira Fechada',
            ),
            secondary: const Icon(Icons.luggage, color: Color(0xFFB71C1C)),
            value: trunkOpen,
            onChanged: (val) => setState(() => trunkOpen = val),
          ),
          const Divider(),

          SwitchListTile(
            title: const Text('Modo Corsa / Desportivo'),
            subtitle: Text(
              sportMode ? 'Válvulas de Escape Abertas' : 'Modo Estrada Normal',
            ),
            secondary: const Icon(Icons.speed, color: Color(0xFFB71C1C)),
            value: sportMode,
            onChanged: (val) => setState(() => sportMode = val),
          ),
          const Divider(),

          SwitchListTile(
            title: const Text('Faróis de Alta Intensidade'),
            subtitle: Text(
              headlightsOn ? 'Faróis Ligados' : 'Faróis Desligados',
            ),
            secondary: const Icon(Icons.highlight, color: Color(0xFFB71C1C)),
            value: headlightsOn,
            onChanged: (val) => setState(() => headlightsOn = val),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.gps_fixed, color: Color(0xFFB71C1C)),
            title: const Text('Rastreio GPS Ativo'),
            subtitle: const Text('Sinal excelente • Braga, Portugal'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('📍 Localização do veículo atualizada.'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

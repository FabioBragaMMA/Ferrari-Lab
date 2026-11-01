import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/action_card.dart';
import 'car_control_screen.dart';
import 'detail_screen.dart';
import 'user_profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int temperatura = 22; // Limites estritos: 16°C a 30°C

  // Dados separados do Condutor e do Veículo (Atualizado para Fábio Braga)
  bool isConnected = false;
  String userName = 'Fábio Braga';
  String carModel = 'Ferrari F50';
  String carVersion = 'Versão Corsa Track Pack (V12 - 4.7L)';
  String userEmail = 'fabio.braga@ferrarilab.com';
  String userPhone = '+351 912 345 678';

  @override
  void initState() {
    super.initState();
    _iniciarConexaoInterna();
  }

  // Simula a conexão Bluetooth / OBD-II a ser estabelecida já DENTRO da app
  void _iniciarConexaoInterna() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isConnected = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚡ Conetado com sucesso ao $carModel!'),
            backgroundColor: Colors.green[800],
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _alterarTemperatura(int delta) {
    setState(() {
      int novaTemp = temperatura + delta;
      if (novaTemp >= 16 && novaTemp <= 30) {
        temperatura = novaTemp;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '⚠️ Limite de temperatura atingido (Min: 16°C | Max: 30°C)',
            ),
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, child) {
        final List<Color> gradientColors = isDark
            ? const [Color(0xFFB71C1C), Color(0xFF5D1010), Color(0xFF1A0505)]
            : const [Color(0xFFFF5252), Color(0xFFE57373), Color(0xFFFFCDD2)];

        final Color textColor = Colors.white;
        final Color cardBackgroundColor = isDark
            ? Colors.white.withOpacity(0.18)
            : Colors.black.withOpacity(0.12);

        final Color cardBorderColor = isDark
            ? Colors.white.withOpacity(0.15)
            : Colors.black.withOpacity(0.1);

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  children: [
                    // Top Bar: Mostra o nome do carro e versão
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              carModel, // Nome do Veículo destacado
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  isConnected ? Icons.check_circle : Icons.sync,
                                  size: 14,
                                  color: isConnected
                                      ? Colors.greenAccent
                                      : Colors.orangeAccent,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isConnected
                                      ? 'Condutor: $userName • $carVersion'
                                      : 'A conectar ao veículo...',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: isConnected
                                        ? Colors.white70
                                        : Colors.orangeAccent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            final resultado = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProfileScreen(
                                  userName: userName,
                                  carModel: carModel,
                                  userEmail: userEmail,
                                  userPhone: userPhone,
                                  carVersion: isConnected
                                      ? carVersion
                                      : 'A procurar...',
                                ),
                              ),
                            );

                            if (resultado != null &&
                                resultado is Map<String, String>) {
                              setState(() {
                                userName = resultado['userName'] ?? userName;
                                carModel = resultado['carModel'] ?? carModel;
                                userEmail = resultado['email'] ?? userEmail;
                                userPhone = resultado['phone'] ?? userPhone;
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xFFD35400),
                              child: Icon(
                                Icons.person,
                                size: 36,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Linha 1: Pressão e Gasolina
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ActionCard(
                              title: 'Pressão',
                              icon: Icons.tire_repair,
                              backgroundColor: cardBackgroundColor,
                              borderColor: cardBorderColor,
                              textColor: textColor,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      title: 'Pressão dos Pneus',
                                      icon: Icons.tire_repair,
                                      carModel: carModel,
                                      carVersion: carVersion,
                                      content: isConnected
                                          ? 'Leitura enviada pelo $carModel (Condutor: $userName):\n\nDianteiro E: 2.3 bar\nDianteiro D: 2.3 bar\nTraseiro E: 2.5 bar\nTraseiro D: 2.5 bar'
                                          : 'A aguardar sincronização com o veículo...',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ActionCard(
                              title: 'Gasolina',
                              icon: Icons.local_gas_station,
                              backgroundColor: cardBackgroundColor,
                              borderColor: cardBorderColor,
                              textColor: textColor,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      title: 'Nível de Combustível',
                                      icon: Icons.local_gas_station,
                                      carModel: carModel,
                                      carVersion: carVersion,
                                      content: isConnected
                                          ? 'Leitura de Combustível:\n\nDepósito: 75%\nAutonomia estimada: 420 km\nRecomendação: Gasolina 98 Octanas'
                                          : 'A aguardar leitura do depósito...',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Linha 2: Temperatura do Carro
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: cardBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: cardBorderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Temperatura do Carro',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                iconSize: 44,
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: textColor,
                                ),
                                onPressed: () => _alterarTemperatura(-1),
                              ),
                              Text(
                                '$temperatura°C',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              IconButton(
                                iconSize: 44,
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: textColor,
                                ),
                                onPressed: () => _alterarTemperatura(1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Linha 3: Modo Dia/Noite e Assistência
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ActionCard(
                              title: isDark ? 'Modo Noite' : 'Modo Dia',
                              icon: isDark
                                  ? Icons.brightness_3
                                  : Icons.wb_sunny,
                              backgroundColor: cardBackgroundColor,
                              borderColor: cardBorderColor,
                              textColor: textColor,
                              onTap: () {
                                bool novoEstado = !isDark;
                                isDarkModeNotifier.value = novoEstado;

                                String mensagem = novoEstado
                                    ? '🌙 Carro alterado para o Modo Noite'
                                    : '☀️ Carro alterado para o Modo Dia';

                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      mensagem,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    backgroundColor: novoEstado
                                        ? Colors.indigo[900]
                                        : Colors.orange[800],
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ActionCard(
                              title: 'Assistência Técnica',
                              icon: Icons.build_circle_outlined,
                              backgroundColor: cardBackgroundColor,
                              borderColor: cardBorderColor,
                              textColor: textColor,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      title: 'Assistência Técnica',
                                      icon: Icons.build_circle_outlined,
                                      carModel: carModel,
                                      carVersion: carVersion,
                                      content:
                                          'Diagnóstico em Tempo Real:\n\nCondutor: $userName\nEmail: $userEmail\nTelemóvel: $userPhone\nEstado Geral: Excelente\nSinal OBD: 100% Estável',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Botão para Segunda Aba
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.25),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: cardBorderColor),
                          ),
                        ),
                        icon: const Icon(Icons.tune, size: 26),
                        label: const Text(
                          'Mais Opções do Carro',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarControlScreen(
                                carModel: carModel,
                                carVersion: carVersion,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

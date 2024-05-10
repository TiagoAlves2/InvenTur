import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventur/models/estado_model.dart';
import 'package:inventur/models/municipio_model.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/pesquisas/widgets/user_pesquisa_card_widget.dart';
import 'package:inventur/pages/widgets/auto_complete_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPesquisa extends StatefulWidget {
  const RegisterPesquisa({super.key});

  @override
  State<RegisterPesquisa> createState() => _RegisterPesquisaState();
}

class _RegisterPesquisaState extends State<RegisterPesquisa> with SingleTickerProviderStateMixin {
  bool _tileExpanded = false;

  List<User> users = [
    User(nome: "Fulano Silva da Costa", cpf: "789.214.878-02", email: "fulanosilva@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Ciclano Fonseca Silva", cpf: "584.978.010-80", email: "ciclano@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    User(nome: "Beltrano Alves Oliveira", cpf: "785.441.210-70", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Fulano Silva da Costa", cpf: "789.214.878-02", email: "fulanosilva@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Ciclano Fonseca Silva", cpf: "584.978.010-80", email: "ciclano@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    User(nome: "Beltrano Alves Oliveira", cpf: "785.441.210-70", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Fulano Silva da Costa", cpf: "789.214.878-02", email: "fulanosilva@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Ciclano Fonseca Silva", cpf: "584.978.010-80", email: "ciclano@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    User(nome: "Beltrano Alves Oliveira", cpf: "785.441.210-70", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Tiago Alves de Lima", cpf: "078.369.222-03", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
  ];

  late Estado? _estadoSelecionado;
  late Municipio? _municipioSelecionado;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final PesquisaController _pesquisaController = PesquisaController();
  final TextEditingController _inicioController = TextEditingController();
  final TextEditingController _terminoController = TextEditingController();
  final TextEditingController _codigIbgeController = TextEditingController();
  final TextEditingController _nomePesquisadorController = TextEditingController();

  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');

  Future<String> selectDate() async {
    late DateTime? selectedDate;
    final DateTime dateNow = DateTime.now();
    
    selectedDate =  await showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: DateTime(dateNow.year),
      lastDate: DateTime(dateNow.year + 30),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        _animationController.forward();
        return ScaleTransition(
          scale: _scaleAnimation,
          child: child,
        );
      },
    );

    _animationController.reverse();

    if (selectedDate != null) {
      return DateFormat('dd/MM/yyyy').format(selectedDate);
    }
    return '';
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _pesquisaController.setUsers = users;
    _pesquisaController.setEstados();
  }

  var appbar = AppBar(
    title: const Text('Cadastrar Nova Pesquisa'),
    foregroundColor: const Color.fromARGB(255, 55, 111, 60),
    backgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final double screenHeight = screenSize.height - MediaQuery.paddingOf(context).top - appbar.preferredSize.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: appbar,
      body: PageView(
        children: [
          SingleChildScrollView(
            child: Container(
              height: screenHeight,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.end,
                              controller: _inicioController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                filled: true,
                                isCollapsed: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "Data Início",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    _inicioController.text = await selectDate();
                                  },
                                  icon: const Icon(
                                    Icons.date_range_rounded,
                                    color: Color.fromARGB(255, 55, 111, 60),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.end,
                              controller: _terminoController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                filled: true,
                                isCollapsed: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "Data Término",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    _terminoController.text = await selectDate();
                                  },
                                  icon: const Icon(
                                    Icons.date_range_rounded,
                                    color: Color.fromARGB(255, 55, 111, 60),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.end,
                              controller: _codigIbgeController,
                              decoration: InputDecoration(
                                filled: true,
                                isCollapsed: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "Código IBGE",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: AutocompleteTextField(
                              label: "Estado",
                              onSelected: (option) {
                                _estadoSelecionado = _pesquisaController.getEstadoByNome(option);
                                _pesquisaController.setMunicipios(_estadoSelecionado!.id);
                              },
                              optionsBuilder: (textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable.empty();
                                }
                                return _pesquisaController.estados.map((e) => e.nome).where(
                                  (word) => word.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase(),
                                  ),
                                );
                              },
                              onChanged: (value) {
                                if (value == '') {
                                  setState(() {
                                    _municipioSelecionado = null;
                                    _codigIbgeController.text = '';
                                    _pesquisaController.municipios.clear();
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AutocompleteTextField(
                        label: "Município",
                        onStateChanged: (textEditingController) {
                          if (_pesquisaController.municipios.isEmpty) textEditingController.text = '';
                        },
                        onSelected: (option) {
                          _municipioSelecionado = _pesquisaController.getMunicipioByNome(option);
                          setState(() {
                            _codigIbgeController.text = _municipioSelecionado!.id.toString();
                          });
                        },
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable.empty();
                          }
                          return _pesquisaController.municipios.map((e) => e.nome).where(
                            (word) => word.toLowerCase().contains(
                              textEditingValue.text.toLowerCase(),
                            ),
                          );
                        },
                        onChanged: (value) {
                          if (value == '') {
                            _codigIbgeController.text = '';
                          }
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: Color.fromARGB(255, 55, 111, 60)
                            )
                          )
                        ),
                        child: ExpansionTile(
                          shape: const Border.symmetric(
                            horizontal: BorderSide(
                              color: Color.fromARGB(255, 55, 111, 60)
                            )
                          ),
                          childrenPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          title: const Row(
                            children: [
                              Spacer(flex: 2),
                              Text(
                                "Adicionar Pesquisador(es)",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 55, 111, 60),
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          trailing: Icon(
                            _tileExpanded
                            ? Icons.remove_rounded
                            : Icons.add_rounded,
                            color: const Color.fromARGB(255, 55, 111, 60),
                            size: 32,
                          ),
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) => Autocomplete<String>(
                                optionsBuilder: (textEditingValue) {
                                  if (textEditingValue.text == '') return const Iterable.empty();
                                  return users.map((e) => e.cpf).where(
                                    (word) => word.contains(textEditingValue.text),
                                  );
                                },
                                optionsViewBuilder: (context, onSelected, options) => Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Container(
                                      width: constraints.biggest.width,
                                      constraints: const BoxConstraints(maxHeight: 200),
                                      child: ListView.separated(
                                        itemCount: options.length,
                                        separatorBuilder: (context, index) => const Divider(
                                          height: 0,
                                          color: Color.fromARGB(255, 55, 111, 60),
                                        ),
                                        itemBuilder: (context, index) {
                                          final User option = users[index];
                                          return InkWell(
                                            borderRadius: options.length == 1
                                            ? const BorderRadius.all(Radius.circular(10))
                                            : index == 0
                                              ? const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )
                                              : index == options.length - 1
                                                ? const BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                )
                                                : null,
                                            onTap: () {
                                              onSelected(option.cpf);
                                              _nomePesquisadorController.text = option.nome;
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                "${option.cpf}\n${option.nome}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(255, 55, 111, 60),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                  return TextField(
                                    focusNode: focusNode,
                                    textAlign: TextAlign.end,
                                    controller: textEditingController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      isCollapsed: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      labelText: "CPF do Pesquisador",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                                      )
                                    ),
                                  );
                                },
                              ),
                            ),
                            AutocompleteTextField(
                              label: "CPF do Pesquisador",
                              inputFormatters: [cpfMask],
                              onSelected: (option) {
                                
                              },
                              optionsBuilder: (textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable.empty();
                                }
                                return users.map((e) => e.cpf).where(
                                  (word) => word.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              readOnly: true,
                              textAlign: TextAlign.end,
                              controller: _nomePesquisadorController,
                              decoration: InputDecoration(
                                filled: true,
                                isCollapsed: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "Nome do Pesquisador",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                    side: const MaterialStatePropertyAll(
                                      BorderSide(
                                        color: Color.fromARGB(255, 55, 111, 60)
                                      )
                                    ),
                                    overlayColor: MaterialStatePropertyAll(
                                      Colors.green[100]
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    children: [
                                      Text(
                                        "Confirmar",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.done_rounded)
                                    ],
                                  ),
                                ),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                    side: const MaterialStatePropertyAll(
                                      BorderSide(
                                        color: Color.fromARGB(255, 232, 0, 0)
                                      )
                                    ),
                                    foregroundColor: const MaterialStatePropertyAll(
                                      Color.fromARGB(255, 232, 0, 0)
                                    ),
                                    overlayColor: MaterialStatePropertyAll(
                                      Colors.red[100]
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    children: [
                                      Text(
                                        "Cancelar",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.clear_rounded)
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                          onExpansionChanged: (expanded) {
                            setState(() {
                              _tileExpanded = expanded;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: ListenableBuilder(
                      listenable: _pesquisaController,
                      builder: (context, child) {
                        return ListView.builder(
                          itemCount: _pesquisaController.userPesquisa.length,
                          itemBuilder: (context, index) {
                            return UserPesquisaCard(
                              user: _pesquisaController.userPesquisa[index],
                              pesquisaController: _pesquisaController,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: screenSize.height * .06,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.012
                                  )
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 55, 111, 60)
                                ),
                                overlayColor: MaterialStateProperty.all(
                                  Colors.green[600]
                                )
                              ),
                              onPressed: () {},
                              child: Text(
                                "Confirmar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.height * .03
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: SizedBox(
                            height: screenSize.height * .06,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.012
                                  )
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 232, 0, 0)
                                ),
                                overlayColor: MaterialStateProperty.all(
                                  Colors.red[500]
                                )
                              ),
                              onPressed: () {
                                
                              },
                              child: Text(
                                "Cancelar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.height * .03
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
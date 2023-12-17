
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:week_7_activities/details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box detailsBox;
  @override
  void initState() {
    super.initState();
       detailsBox = Hive.box<Details>('details');
  }
  final formKey = GlobalKey<FormState>();
  String? name1;
  int? age1;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('App Bar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              onSaved: (newValue) {
                name1 = newValue;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'name is required';
                } else {
                  return null;
                }
              },
              controller: nameController,
              decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onSaved: (newValue) {
                age1 =int.parse(newValue!) ;
              },
              controller: ageController,
              decoration: InputDecoration(
                  hintText: 'Age',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'age is required ';
                } else {
                  return null;
                }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    saveData();
                  });
                },
                child: const Text('Save')),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final data = detailsBox.getAt(index) as Details;
                      return ListTile(
                        title: Text(data.name),
                        subtitle: Text(data.age.toString()),trailing:InkWell(child: Icon(Icons.delete),onTap: () {
                          setState(() {
                            detailsBox.deleteAt(index);
                          });
                          
                        },),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const Divider(thickness: 5,height:2 ,);
                    },
                    itemCount: detailsBox.length))
          ]),
        ),
      ),
    );
  }

  saveData() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState?.save();
      detailsBox.add(Details(name: name1!, age: age1!));
      nameController.clear();
      ageController.clear();
    }
  }
 
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddUserScreen extends StatefulWidget {
  final String name;
  final String rocket;
  final String twitter;

  const AddUserScreen({
    Key key,
    this.name,
    this.rocket,
    this.twitter,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddUserScreenState();
  }
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _rocketNameController = TextEditingController();
  final _twitterController = TextEditingController();

  bool _isSaving = false;
  VoidCallback refetchQuery;

  String _insertUser() {
    return """
    mutation insertUser(\$name: String!, \$rocket: String!, \$twitter: String!) {
      insert_users(objects: {
        name: \$name,
        rocket: \$rocket,
        twitter: \$twitter,
      }) {
        returning {
          id
          name
          twitter
          rocket
        }
      }
    }
    """;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New User",
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 36,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  color: Colors.grey.shade300,
                  blurRadius: 30,
                ),
              ],
            ),
            child: Mutation(
              options: MutationOptions(
                  document: gql(_insertUser()),
                  onCompleted: (data) {
                    refetchQuery();
                    Navigator.pop(context, true);
                  },
                  update: (GraphQLDataProxy cache, QueryResult result) {
                    if (result.hasException) {
                      print(result.exception);
                    } else {
                      print(result.data);
                    }
                  }),
              builder: (
                RunMutation runMutation,
                QueryResult result,
              ) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _nameController,
                        decoration: new InputDecoration(
                          labelText: "Name",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        validator: (v) {
                          if (v.length == 0) {
                            return "Name cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: _rocketNameController,
                        decoration: InputDecoration(
                          labelText: "Rocket name",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        validator: (v) {
                          if (v.length == 0) {
                            return "Rocket name cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: _twitterController,
                        decoration: InputDecoration(
                          labelText: "Twitter handle",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        validator: (v) {
                          if (v.length == 0) {
                            return "Twitter cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 24),
                      _isSaving
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            )
                          : TextButton(
                              style: ButtonStyle(),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _isSaving = true;
                                  });

                                  runMutation({
                                    'name': _nameController.text,
                                    'rocket': _rocketNameController.text,
                                    'twitter': _twitterController.text,
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 36,
                                  vertical: 12,
                                ),
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

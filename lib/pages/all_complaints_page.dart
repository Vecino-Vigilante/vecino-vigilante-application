import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vecino_vigilante/configurations/routes_enum.dart';
import 'package:vecino_vigilante/http/get_all_complaints.dart';
import 'package:vecino_vigilante/layouts/main/app_bar.dart';
import 'package:vecino_vigilante/layouts/main/drawer/drawer_navigation.dart';
import 'package:vecino_vigilante/models/complaint_model.dart';
import 'package:vecino_vigilante/widgets/complaint_card.dart';
import 'package:vecino_vigilante/widgets/complaints_search_bar.dart';

class AllComplaintsPage extends StatelessWidget {
  const AllComplaintsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: Navbar.render(context),
      drawer: const DrawerNavigation(),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text("Crear denuncia"),
        onPressed: () => context.push(RoutesEnum.newComplaint.path),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 31),
          child: FutureBuilder<List<ComplaintModel>>(
            future: getAllComplaints(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const ComplaintsSearchBar(),
                    const SizedBox(
                      height: 33,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final complaint = snapshot.data?.elementAt(index);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ComplaintCard(
                              complaint: complaint!,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "¡Oh, no! Se produjo un error al intentar obtener las denuncias.",
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

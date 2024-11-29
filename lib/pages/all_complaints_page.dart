import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vecino_vigilante/configurations/routes_enum.dart';
import 'package:vecino_vigilante/dto/complaint_dto.dart';
import 'package:vecino_vigilante/http/get_all_complaints.dart';
import 'package:vecino_vigilante/layouts/main_layout.dart';
import 'package:vecino_vigilante/widgets/complaint_card.dart';
import 'package:vecino_vigilante/widgets/custom_search_bar.dart';

class AllComplaintsPage extends StatefulWidget {
  const AllComplaintsPage({
    super.key,
  });

  @override
  State<AllComplaintsPage> createState() => _AllComplaintsPageState();
}

class _AllComplaintsPageState extends State<AllComplaintsPage> {
  bool _isLoading = true;
  List<ComplaintDTO> _complaints = [];
  List<ComplaintDTO> _filteredComplaints = [];

  @override
  void initState() {
    super.initState();
    _fetchComplaints();
  }

  Future<void> _fetchComplaints() async {
    try {
      final complaints = await getAllComplaints();

      setState(() {
        _complaints = complaints ?? [];
        _filteredComplaints = complaints ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterComplaints(String query) {
    setState(() {
      _filteredComplaints = _complaints.where((complaint) {
        final description = complaint.description?.toLowerCase();
        final direction = complaint.location?.direction?.toLowerCase();
        final queryLower = query.toLowerCase();

        return (description != null && description.contains(queryLower)) ||
            (direction != null && direction.contains(queryLower));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return MainLayout(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text("Crear denuncia"),
        onPressed: () => context.push(RoutesEnum.newComplaint.path),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _complaints.isEmpty
              ? const Center(
                  child: Text(
                    "No hay incidencias disponibles para mostrar.",
                    textAlign: TextAlign.center,
                  ),
                )
              : Column(
                  children: [
                    CustomSearchBar(
                      onSearch: _filterComplaints,
                      placeholder: "Buscar denuncias por título o dirección",
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _fetchComplaints,
                        child: ListView.builder(
                          itemCount: _filteredComplaints.length,
                          itemBuilder: (context, index) {
                            final complaint = _filteredComplaints[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ComplaintCard(
                                complaint: complaint,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}

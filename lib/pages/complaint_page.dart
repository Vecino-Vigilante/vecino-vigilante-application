import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vecino_vigilante/configurations/constants.dart';
import 'package:vecino_vigilante/dto/comment_dto.dart';
import 'package:vecino_vigilante/dto/complaint_dto.dart';
import 'package:vecino_vigilante/dto/location_dto.dart';
import 'package:vecino_vigilante/dto/user_dto.dart';
import 'package:vecino_vigilante/http/create_comment.dart';
import 'package:vecino_vigilante/http/get_complaint_by_id.dart';
import 'package:vecino_vigilante/http/requests/create_comment_request.dart';
import 'package:vecino_vigilante/layouts/main_layout.dart';
import 'package:vecino_vigilante/utils/auth_utils.dart';
import 'package:vecino_vigilante/utils/date_utils.dart';

class ComplaintPage extends StatefulWidget {
  final String? complaintId;

  const ComplaintPage({
    super.key,
    required this.complaintId,
  });

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  List<CommentDTO> _comments = [];
  final TextEditingController _commentController = TextEditingController();

  Future<void> createCommentAndUpdateComments(String content) async {
    final commentRequest = CreateCommentRequest(
      content: content,
      date: DateTime.now(),
      incidentId: widget.complaintId,
      resource: null,
      userId: await AuthUtils.getAuthenticatedUserId(),
    );

    await createComment(commentRequest);

    final updatedComplaint = await getComplaintById(widget.complaintId ?? "");

    setState(() {
      _comments = updatedComplaint?.comments ?? [];
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchComplaint();
  }

  Future<void> _fetchComplaint() async {
    final complaint = await getComplaintById(widget.complaintId ?? "");

    setState(() {
      _comments = complaint?.comments ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      floatingActionButton: null,
      body: FutureBuilder<ComplaintWithCommentsDTO?>(
        future: getComplaintById(widget.complaintId ?? ""),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final complaint = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: complaint.imageUrl != null
                          ? Image.network(
                              complaint.imageUrl!,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;

                                return Container(
                                  color: Colors.grey.shade200,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const Icon(
                                        Icons.image,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                      Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : const Icon(
                              Icons.image,
                              size: 100,
                              color: Colors.grey,
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      complaint.type?.name ?? 'Sin tipo',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      complaint.description ?? 'Sin descripción',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      complaint.date != null
                          ? getSpanishDateFormat(complaint.date!)
                          : 'Sin fecha',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    _buildUserSection(complaint.user),
                    const SizedBox(height: 16),
                    _buildLocationSection(complaint.location),
                    const SizedBox(height: 16),
                    _buildAddCommentSection(),
                    const SizedBox(height: 16),
                    _buildCommentsSection(_comments),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "¡Oh, no! Se produjo un error al intentar obtener la información de la denuncia",
                textAlign: TextAlign.center,
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildUserSection(UserDTO? user) {
    if (user == null) return const SizedBox.shrink();

    final userFullname = '${user.name} ${user.lastName}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Usuario:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            CircleAvatar(
              child: CachedNetworkImage(
                imageUrl:
                    "https://api.dicebear.com/7.x/micah/png?seed=$userFullname",
              ),
            ),
            const SizedBox(width: 10),
            Text(userFullname),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationSection(LocationDTO? location) {
    if (location == null) return const SizedBox.shrink();

    final complaintPosition = LatLng(
      location.latitude ?? meridaCenterLatitude,
      location.longitude ?? meridaCenterLongitude,
    );

    final complaintMarker = Marker(
      markerId: const MarkerId("complaint-position"),
      position: complaintPosition,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ubicación:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text('Dirección: ${location.direction ?? ''}'),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: complaintPosition,
              zoom: 16,
            ),
            markers: {complaintMarker},
            myLocationButtonEnabled: false,
            scrollGesturesEnabled: false,
            zoomGesturesEnabled: false,
          ),
        ),
      ],
    );
  }

  Widget _buildAddCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 20),
        const Text(
          'Añadir Comentario:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _commentController,
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe tu comentario aquí...',
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            final content = _commentController.text;
            if (content.isNotEmpty) {
              await createCommentAndUpdateComments(content);
              _commentController.clear();
            }
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }

  Widget _buildCommentsSection(List<CommentDTO>? comments) {
    if (comments == null || comments.isEmpty) {
      return const Text(
        'No hay comentarios',
        style: TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comentarios:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...comments.map((comment) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${comment.user?.name} ${comment.user?.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(comment.content ?? ''),
                const SizedBox(height: 4),
                Text(
                  comment.date != null
                      ? getSpanishDateFormat(comment.date!)
                      : 'Sin fecha',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScoutEvaluationFormPage extends StatefulWidget {
  const ScoutEvaluationFormPage({super.key});

  @override
  State<ScoutEvaluationFormPage> createState() => _ScoutEvaluationFormPageState();
}

class _ScoutEvaluationFormPageState extends State<ScoutEvaluationFormPage> {
  final supabase = Supabase.instance.client;
  final Map<String, double> _scores = {};
  String? _selectedPlayerId;
  String? _comment;
  bool _submitting = false;
  List<Map<String, dynamic>> _players = [];

  final traits = ["Technique", "Vision", "Speed", "Stamina", "Positioning", "Decision-Making"];

  @override
  void initState() {
    super.initState();
    _fetchPlayers();
  }

  Future<void> _fetchPlayers() async {
    final response = await supabase
        .from('footballer_profiles')
        .select('id, full_name')
        .order('full_name');
    setState(() => _players = List<Map<String, dynamic>>.from(response));
  }

  Future<void> _submitEvaluation() async {
    if (_selectedPlayerId == null || _scores.length != traits.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields")),
      );
      return;
    }

    setState(() => _submitting = true);

    final scoutId = supabase.auth.currentUser?.id;
    final evaluation = {
      "scout_id": scoutId,
      "player_id": _selectedPlayerId,
      "scores": _scores,
      "comment": _comment,
      "approved": true,
    };

    await supabase.from('scout_evaluations').insert(evaluation);

    setState(() => _submitting = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Evaluation submitted")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Scout Evaluation", style: TextStyle(color: Colors.white)),
      ),
      body: _submitting
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select Player", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
  dropdownColor: Colors.grey[900],
  value: _selectedPlayerId,
  items: _players
      .map((p) => DropdownMenuItem<String>(
            value: p['id'].toString(), // ensure it's a String
            child: Text(p['full_name'] ?? 'Unnamed', style: const TextStyle(color: Colors.white)),
          ))
      .toList(),
  onChanged: (value) => setState(() => _selectedPlayerId = value),
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.grey[800],
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  ),
),
              const SizedBox(height: 20),
                  for (var trait in traits)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(trait, style: const TextStyle(color: Colors.white)),
                        Slider(
                          value: _scores[trait] ?? 5,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: "${_scores[trait]?.round() ?? 5}",
                          onChanged: (value) {
                            setState(() {
                              _scores[trait] = value;
                            });
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  TextField(
                    maxLines: 3,
                    onChanged: (val) => _comment = val,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Optional comment...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _submitEvaluation,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.greenAccent[700]),
                    child: const Text("Submit & Approve"),
                  )
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '/models/candi.dart';
import '/data/candi_data.dart';
import '/screens/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //TODO 1: Deklarasikan variabel yang dibutuhkan
  late List<Candi> _filteredCandi;
  String _searchQuery = "";
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _filteredCandi = candiList;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 2: Buat appbar dengan judul pencarian candi
      appBar: AppBar(title: Text('Pencarian Candi')),
      // TODO 3: Buat Body Berupa Column
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple[50],
              ),
              child: TextField(
                autofocus: false,
                // TODO: 6. Implementasi fitur pencarian
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                    if (query.isEmpty) {
                      _filteredCandi = candiList;
                    } else {
                      _filteredCandi = candiList
                          .where(
                            (candi) => candi.name.toLowerCase().contains(
                              query.toLowerCase(),
                            ),
                          )
                          .toList();
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari Candi...',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  // TODO: 7. Implementasi pengosongan input
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                              _filteredCandi = candiList;
                            });
                          },
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                controller: _searchController,
              ),
            ),
          ),
          // TODO 5: Buat ListView Candi sebagai anak dari column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: _filteredCandi.length,
                itemBuilder: (context, index) {
                  final candi = _filteredCandi[index];
                  return GestureDetector(
                    onTap: () {
                      // TODO: 8. Implementasi GestureDetector dan Hero animation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(candi: candi),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Hero(
                                tag: 'candi-${candi.name}',
                                child: Image.asset(
                                  candi.imageAsset,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  candi.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(candi.location),
                              ],
                            ),
                          ),
                        ],
                      ),
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

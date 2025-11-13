import 'package:flutter/material.dart';
import 'package:wisata_candi_mrizki_algipari/models/candi.dart';


class SearchScreen extends StatefulWidget{
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  @override
  //TODO 1: Deklarasikan variabel yang dibutuhkan 
  List<Candi> _filteredCandi = [];
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 2: Buat appbar dengan judul pencarian candi
      appBar: AppBar(title: Text('Pencarian Candi'),),
      // TODO 3: Buat Body Berupa Column
      body: Column(children: [
      TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Cari candi',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
      // TODO 5: Buat ListView menampilkan hasil pencarian sebagai anak dari column
      ListView.builder(
        itemCount: _filteredCandi.length,
        itemBuilder: (context, index){
          final candi = candi _filteredCandi[index];
          return Card();
        }
      )
      ],)
    );
  }
}

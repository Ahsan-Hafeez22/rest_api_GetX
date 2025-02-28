import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/model/dictionary_model.dart';
import 'package:rest_api_project/view_model/controller/dictionary_controller.dart';

class HomeDictionaryPage extends StatefulWidget {
  const HomeDictionaryPage({super.key});

  @override
  State<HomeDictionaryPage> createState() => _HomeDictionaryPageState();
}

class _HomeDictionaryPageState extends State<HomeDictionaryPage> {
  final DictionaryController dc = Get.put(DictionaryController());
  final TextEditingController searchController = TextEditingController();

  void searchWord() {
    String searchTerm = searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      dc.hasSearch.value = true;
      dc.getDictionary(searchTerm);
    } else {
      Get.snackbar('Empty Field', 'Please enter a word.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dictionary App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightGreen,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                // Get.offNamed(RoutesName.appSelectionScreen);
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search a word',
                      border: OutlineInputBorder(),
                    ),
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: searchWord,
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (!dc.hasSearch.value) {
                return _buildInitialMessage();
              }
              switch (dc.rxRequestStatus.value) {
                case Status.LOADING:
                  return const LinearProgressIndicator();
                case Status.COMPLETED:
                  return _buildDictionaryResult();
                case Status.ERROR:
                  return _buildErrorMessage();
              }
            })
          ],
        ),
      ),
    );
  }

  Widget _buildInitialMessage() {
    return Center(
      child: Text(
        "Enter a word to explore its meaning, synonyms, antonyms, pronunciation, and more!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.italic,
          color: Colors.grey[500],
        ),
      ),
    );
  }

  Widget _buildDictionaryResult() {
    if (dc.dictionaryResponseList.isEmpty) {
      return _buildNoResultsFound();
    }
    var wordData = dc.dictionaryResponseList[0];
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              wordData.word.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.blue),
            ),
          ),
          if (wordData.phonetics.isNotEmpty &&
              wordData.phonetics[0].text != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                wordData.phonetics[0].text!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue),
              ),
            ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: wordData.meanings.length,
              itemBuilder: (context, index) {
                return _buildMeaning(wordData.meanings[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsFound() {
    return Center(
      child: Text(
        "No results found. Please check the spelling and try again.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.red[600],
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    log('Error: ${dc.error.value}');
    return Center(
      child: Text(
        'Sorry pal, we could not find definitions for the word you were looking, You can try the search again at later time or head to the web instead.',
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
      ),
    );
  }

  Widget _buildMeaning(Meaning meaning) {
    String wordDefinition = meaning.definitions.map((e) {
      int index = meaning.definitions.indexOf(e) + 1;
      return "$index. ${e.definition}";
    }).join("\n\n");

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meaning.partOfSpeech,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blue),
              ),
              const SizedBox(height: 10),
              const Text(
                "Definition:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
              Text(
                wordDefinition,
                style:
                    const TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

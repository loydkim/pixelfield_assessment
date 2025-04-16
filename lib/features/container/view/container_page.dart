import 'package:flutter/material.dart';
import 'package:pixelfield_project/features/container/view/view.dart';
import 'package:pixelfield_project/features/my_collection/model/my_collection.dart';

class ContainerPage extends StatefulWidget {
  final MyCollection myCollection;
  const ContainerPage({super.key, required this.myCollection});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() => setState(() {});

  @override
  Widget build(BuildContext context) {
    // Dark background color for fallback behind bg.png
    const Color backgroundColor = Color(0xFF0b1519);
    const Color detailBGColor = Color(0xFF122329);
    const Color panelColor = Color(0xFF101D21);
    const Color accentColor = Color(0xFFFFB800);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        // Make the entire screen scrollable
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Top bar: "Genesis Collection" + "Genuine Bottle (Unopened)" + "X" icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // "Genesis Collection"
                      Container(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            '${widget.myCollection.type} Collection',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // Close (X) icon
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              // Handle close action
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // "Genuine Bottle (Unopened)"
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.settings,
                              color: accentColor,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${widget.myCollection.type} Bottle (Unopened)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: accentColor,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 44),
                  // Bottle Image
                  Center(
                    child: Image.asset(
                      widget.myCollection.imagePath,
                      width: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Bottle info: "Bottle 135/184" + "Talisker 18 Year old #2504"
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: detailBGColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 14.0,
                        left: 14.0,
                        right: 14.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            'Bottle ${widget.myCollection.currentCount}/${widget.myCollection.totalCount}',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              text: widget.myCollection.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                                height: 1.3,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      ' ${DateTime.now().year - widget.myCollection.year} Year old',
                                  style: TextStyle(
                                    color: accentColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: ' #${widget.myCollection.number}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Tabs: "Details", "Tasting notes", "History"
                          Container(
                            decoration: BoxDecoration(
                              color: panelColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildTabItem('Details', 0),
                                _buildTabItem('Tasting notes', 1),
                                _buildTabItem('History', 2),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),

                          // PageView with three pages
                          SizedBox(
                            height:
                                420, // Adjust based on expected content height
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                DetailPage(panelColor: detailBGColor),
                                TastingNotesPage(
                                  title: 'Tasting notes',
                                  panelColor: detailBGColor,
                                ),
                                // 3) History
                                HistoryPage(
                                  title: 'History',
                                  panelColor: detailBGColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Bottom button: "Add to my collection"
                  Container(
                    width: 220,
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        // primary: accentColor,
                        backgroundColor: accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Handle "Add to my collection" action
                      },
                      icon: const Icon(Icons.add, color: Colors.black),
                      label: const Text(
                        'Add to my collection',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for each tab item
  Widget _buildTabItem(String label, int index) {
    const Color panelColor = Color(0xFF101D21);
    const Color accentColor = Color(0xFFFFB800);
    final bool isSelected = (_tabController.index == index);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tabController.index = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? accentColor : panelColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? panelColor : Colors.white70,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

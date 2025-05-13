import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/provider/mapping_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CostModelContainer extends StatelessWidget {
  const CostModelContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final mappingProvider =
        Provider.of<MappingProvider>(context, listen: false);
    return Container(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        itemCount: mappingProvider.costModels.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              mappingProvider
                  .setCostingModel(mappingProvider.costModels[index]);
            },
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: mappingProvider.selctedcostingModel['label'] ==
                        mappingProvider.costModels[index]['label']
                    ? secondaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    mappingProvider.costModels[index]['icon'],
                    color: black2,
                    size: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

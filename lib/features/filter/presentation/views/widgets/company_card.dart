import 'package:flutter/material.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/company_item.dart';

class CompanyCard extends StatelessWidget {
  final CompanyItem item;
  final bool isGrid;

  const CompanyCard({required this.item, required this.isGrid, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: isGrid
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: item.img != null
                ? Image.network(item.img!, fit: BoxFit.cover)
                : Placeholder(),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  item.desc ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14),
                    SizedBox(width: 4),
                    Flexible(child: Text(item.location ?? '')),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
          : ListTile(
        leading: item.img != null
            ? Image.network(item.img!, width: 60, fit: BoxFit.cover)
            : SizedBox(width: 60, child: Placeholder()),
        title: Text(item.name ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.desc ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 14),
                SizedBox(width: 4),
                Flexible(child: Text(item.location ?? '')),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            item.fav == true ? Icons.favorite : Icons.favorite_border,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
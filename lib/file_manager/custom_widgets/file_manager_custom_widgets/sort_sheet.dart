
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../provider/FileManagerProvider/category_provider.dart';

class SortSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              'Sort by'.toUpperCase(),
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.builder(
                itemCount: AppConstants.sortList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () async {
                      await Provider.of<CategoryProvider>(context,
                              listen: false)
                          .setSort(index);
                      Navigator.pop(context);
                    },
                    contentPadding: EdgeInsets.all(0),
                    trailing: index ==
                            Provider.of<CategoryProvider>(context,
                                    listen: false)
                                .sort
                        ? Icon(
                            Icons.check,
                            color: Colors.blue,
                            size: 16,
                          )
                        : SizedBox(),
                    title: Text(
                      '${AppConstants.sortList[index]}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: index ==
                                Provider.of<CategoryProvider>(context,
                                        listen: false)
                                    .sort
                            ? Colors.blue
                            : Theme.of(context).textTheme.headline6!.color,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

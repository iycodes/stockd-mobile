// part of "/presentation/state/bloc/item_bloc.dart";

part of 'item_cubit.dart';

class ItemState extends Equatable {
  final EventStatus status;
  final Item? data;
  List<ExtractColors>? colorsList;
  ItemState({required this.status, this.data, this.colorsList}) {
    if (data != null) {
      final List<ExtractColors> colors = [];
      final colors1 = data?.colors;

      for (var i = 0; i < data!.colors!.length; i++) {
        print("colorrs =>>> ${colors1![i]["sizes"]}");

        colors.add(
            ExtractColors.initiate(colors1[i]["color"], colors1[i]["sizes"]));
      }
      colorsList = colors;
    }
  }

  static ItemState initial() => ItemState(status: EventStatus.initial);

  ItemState copyWith({EventStatus? status, Item? data}) {
    // print(data)

    return ItemState(
        status: status ?? this.status,
        data: data ?? this.data,
        colorsList: colorsList);
  }

  @override
  List<Object?> get props => [status, data];
}

class ExtractColors {
  final String color;
  final List<ItemSize> sizes;
  final List<List<ItemSize>> nestedSizes;

  ExtractColors(this.color, this.sizes, this.nestedSizes);
  static ExtractColors initiate(String color, List<dynamic> sizeList) {
    final sizes = sizeList.map((e) {
      final index = e.indexOf("-");
      final size = e.substring(0, index);
      final qty = int.parse(e.substring(index + 1));
      return ItemSize(size, qty);
    }).toList();
    List<List<ItemSize>> nestedSizes = [];
    List<ItemSize> sizeRow = [];
    for (var i = 0; i < sizes.length; i++) {
      if (sizeRow.length == 3) {
        nestedSizes.add([...sizeRow]);
        sizeRow.clear();
      }
      sizeRow.add(sizes[i]);
    }
    final int leftOverCount = sizes.length % 3;
    if (leftOverCount != 0) {
      final List<ItemSize> leftOverList = [];
      for (var i = 0; i < leftOverCount; i++) {
        final ItemSize leftOver = sizes[sizes.length - 1 - i];
        leftOverList.add(leftOver);
      }

      nestedSizes.add(leftOverList);
    }

    return ExtractColors(
      color,
      sizes,
      nestedSizes,
    );
  }
}

class ItemSize {
  final String size;
  final int quantity;
  ItemSize(this.size, this.quantity);
}

enum EventStatus {
  initial,
  loading,
  loaded,
  updated,
  error,
  noInternet,
}

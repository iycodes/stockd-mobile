// void main() {
//   final test = _TestingColors.initiate("BLACK&GREY",
//       ["S-2", "XL-5", "XXL-3", "L-5", "M-3", "XL-5", "AB-5", "AB-5"]);
//   // print(test.nestedSizes[0].length);
// }

// class _Size {
//   final String size;
//   final int quantity;
//   _Size(this.size, this.quantity);
// }

// class _TestingColors {
//   final String color;
//   final List<_Size> sizes;
//   final List<List<_Size>> nestedSizes;

//   _TestingColors(this.color, this.sizes, this.nestedSizes);
//   static _TestingColors initiate(String color, List<String> sizeList) {
//     final sizes = sizeList.map((String e) {
//       final index = e.indexOf("-");
//       final size = e.substring(0, index);
//       final qty = int.parse(e.substring(index + 1));
//       return _Size(size, qty);
//     }).toList();
//     List<List<_Size>> nestedSizes = [];
//     List<_Size> sizeRow = [];
//     for (var i = 0; i < sizes.length; i++) {
//       print("sizeRow.length=> $nestedSizes");

//       if (sizeRow.length == 3) {
//         nestedSizes.add([...sizeRow]);
//         sizeRow.clear();
//       }
//       sizeRow.add(sizes[i]);
//     }
//     final int leftOverCount = sizes.length % 3;
//     if (leftOverCount != 0) {
//       final List<_Size> leftOverList = [];
//       for (var i = 0; i < leftOverCount; i++) {
//         final _Size leftOver = sizes[sizes.length - 1 - i];
//         leftOverList.add(leftOver);
//       }
//       print("leftOverList => $leftOverList");
//       nestedSizes.add(leftOverList);
//     }

//     print("nestedSizes => $nestedSizes");
//     return _TestingColors(
//       color,
//       sizes,
//       nestedSizes,
//     );
//   }
// }
// var updateAa;

void main() {
  List a = [3];
  // updateAa = () {
  //   a = 7;
  // };
  print("a before func $a ");
  updateA(a);
  print("a after func => $a");
}

updateA(List a) {
  a[0] = 10;
}

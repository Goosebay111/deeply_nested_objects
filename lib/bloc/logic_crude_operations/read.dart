import 'package:deeply_nested_objects/bloc/collection/collection_state.dart';

List<CollectionState> getAllNodesOfParent(
    {required CollectionState parentNode}) {
  final List<CollectionState> result = [];
  result.add(parentNode);

  for (CollectionState node in parentNode.children) {
    result.addAll(getAllNodesOfParent(parentNode: node));
  }
  return result;
}

List<CollectionState> getAllNodesOfParentExcludingParent(
    {required CollectionState parentNode}) {
  final List<CollectionState> result = [];

  for (CollectionState node in parentNode.children) {
    result.addAll(getAllNodesOfParent(parentNode: node));
  }
  return result;
}

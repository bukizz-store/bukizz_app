//
//
// class CategoryModel {
//   CategoryModel({
//     this.id,
//     this.name,
//     this.image,
//     this.description,
//     this.parent,
//     this.slug,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.children,
//   });
//
//   int id;
//   String name;
//   String image;
//   String description;
//   int parent;
//   String slug;
//   int status;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic deletedAt;
//   List<CategoryModel> children;
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
//     id: json["id"],
//     name: json["name"],
//     image: json["image"],
//     description: json["description"],
//     parent: json["parent"],
//     slug: json["slug"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     children: List<CategoryModel>.from(json["children"].map((x) => CategoryModel.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "image": image,
//     "description": description,
//     "parent": parent,
//     "slug": slug,
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "deleted_at": deletedAt,
//     "children": List<dynamic>.from(children.map((x) => x.toJson())),
//   };
// }
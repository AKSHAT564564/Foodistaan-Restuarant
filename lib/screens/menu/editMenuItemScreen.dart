import 'package:flutter/material.dart';
import 'package:foodistaan_restuarant/utils/constants.dart';
import 'package:foodistaan_restuarant/model/menuItemModel.dart';
import 'package:foodistaan_restuarant/provider/menuItemsProvider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditMenuItemScreen extends StatefulWidget {
  static const routeName = '/edit-MenuItem';

  @override
  _EditMenuItemScreenState createState() => _EditMenuItemScreenState();
}

class _EditMenuItemScreenState extends State<EditMenuItemScreen> {
  final _idFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  final _cuisineFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _maxQuantityFocusNode = FocusNode();
  final _vegFocusNode = FocusNode();
  final _discountFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var _editedMenuItem = MenuItem(
    id: "",
    title: "",
    cuisine: "",
    description: "",
    maxQuantity: "",
    veg: false,
    discountOff: 0,
    price: 0,
    image: "",
  );
  var _initValues = {
    'id': "",
    'title': "",
    'cuisine': "",
    'description': "",
    'maxQuantity': "",
    'veg': "",
    'discountOff': "",
    'price': "",
    'image': "",
  };

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final menuItemId = ModalRoute.of(context)!.settings.arguments as String;
      if (menuItemId.isNotEmpty) {
        _editedMenuItem =
            Provider.of<MenuItems>(context, listen: false).findById(menuItemId);
        _initValues = {
          'id': _editedMenuItem.id,
          'title': _editedMenuItem.title,
          'cuisine': _editedMenuItem.cuisine,
          'description': _editedMenuItem.description,
          'maxQuantity': _editedMenuItem.maxQuantity,
          'veg': _editedMenuItem.veg.toString(),
          'discountOff': _editedMenuItem.discountOff.toString(),
          'price': _editedMenuItem.price.toString(),
          'image': "",
        };
        _imageController.text = _editedMenuItem.image;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _idFocusNode.dispose();
    _titleFocusNode.dispose();
    _cuisineFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _maxQuantityFocusNode.dispose();
    _vegFocusNode.dispose();
    _discountFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageController.dispose();
    _imageFocusNode.removeListener(_updateImage);
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageController.text.startsWith('http') &&
              !_imageController.text.startsWith('https')) ||
          (!_imageController.text.endsWith('.png') &&
              !_imageController.text.endsWith('.jpg') &&
              !_imageController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_editedMenuItem.id != null) {
        await Provider.of<MenuItems>(context, listen: false)
            .updateMenuItem(_editedMenuItem.id, _editedMenuItem);
      }
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.$error'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 7.h,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save, color: kYellow),
          ),
        ],
        title: Text(
          "Edit Menu Item",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: kYellow,
              ),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  margin: EdgeInsets.only(bottom: 2.5.h),
                  padding: EdgeInsets.all(1.h),
                  child: Form(
                    key: _form,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 30.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 20.h,
                                height: 20.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black),
                                    // borderRadius: BorderRadius.all(Radius.circular(20)),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                    color: Colors.white),
                                child: _imageController.text.isEmpty
                                    ? Container(
                                        child: Icon(
                                        Icons.add_a_photo_rounded,
                                        size: 50.sp,
                                      ))
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          // borderRadius:
                                          //     BorderRadius.all(Radius.circular(20)),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                _imageController.text),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Image URL'),
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  controller: _imageController,
                                  focusNode: _imageFocusNode,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_idFocusNode);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter an image URL.';
                                    }
                                    if (!value.startsWith('http') &&
                                        !value.startsWith('https')) {
                                      return 'Please enter a valid URL.';
                                    }
                                    if (!value.endsWith('.png') &&
                                        !value.endsWith('.jpg') &&
                                        !value.endsWith('.jpeg')) {
                                      return 'The Image URL is not correct.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedMenuItem = MenuItem(
                                      id: _editedMenuItem.id,
                                      title: _editedMenuItem.title,
                                      cuisine: _editedMenuItem.cuisine,
                                      description: _editedMenuItem.description,
                                      maxQuantity: _editedMenuItem.maxQuantity,
                                      veg: _editedMenuItem.veg,
                                      discountOff: _editedMenuItem.discountOff,
                                      price: _editedMenuItem.price,
                                      image: value!,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          initialValue: _initValues['id'],
                          decoration: InputDecoration(labelText: 'ID'),
                          textInputAction: TextInputAction.next,
                          focusNode: _idFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_titleFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The ID must not be empty.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedMenuItem = MenuItem(
                              id: value!,
                              title: _editedMenuItem.title,
                              cuisine: _editedMenuItem.cuisine,
                              description: _editedMenuItem.description,
                              maxQuantity: _editedMenuItem.maxQuantity,
                              veg: _editedMenuItem.veg,
                              discountOff: _editedMenuItem.discountOff,
                              price: _editedMenuItem.price,
                              image: _editedMenuItem.image,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['title'],
                          decoration: InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          focusNode: _titleFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_cuisineFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The title must not be empty.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedMenuItem = MenuItem(
                              id: _editedMenuItem.id,
                              title: value!,
                              cuisine: _editedMenuItem.cuisine,
                              description: _editedMenuItem.description,
                              maxQuantity: _editedMenuItem.maxQuantity,
                              veg: _editedMenuItem.veg,
                              discountOff: _editedMenuItem.discountOff,
                              price: _editedMenuItem.price,
                              image: _editedMenuItem.image,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['cuisine'],
                          decoration: InputDecoration(labelText: 'Cuisine'),
                          textInputAction: TextInputAction.next,
                          focusNode: _cuisineFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The Cuisine must not be empty.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedMenuItem = MenuItem(
                              id: _editedMenuItem.id,
                              title: _editedMenuItem.title,
                              cuisine: value!,
                              description: _editedMenuItem.description,
                              maxQuantity: _editedMenuItem.maxQuantity,
                              veg: _editedMenuItem.veg,
                              discountOff: _editedMenuItem.discountOff,
                              price: _editedMenuItem.price,
                              image: _editedMenuItem.image,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['description'],
                          decoration: InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_maxQuantityFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The description must not be empty.';
                            }
                            if (value.length < 10) {
                              return 'The description must be atleast 10 characters.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedMenuItem = MenuItem(
                              id: _editedMenuItem.id,
                              title: _editedMenuItem.title,
                              cuisine: _editedMenuItem.cuisine,
                              description: value!,
                              maxQuantity: _editedMenuItem.maxQuantity,
                              veg: _editedMenuItem.veg,
                              discountOff: _editedMenuItem.discountOff,
                              price: _editedMenuItem.price,
                              image: _editedMenuItem.image,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['maxQuantity'],
                          decoration:
                              InputDecoration(labelText: 'Max Quantity'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _maxQuantityFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_vegFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The Max Quantity must not be empty.';
                            }
                            if (int.tryParse(value) == null) {
                              return 'The Max Quantity must be in a number format.';
                            }
                            if (int.parse(value) <= 0) {
                              return 'The Max Quantity should not be less than zero.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedMenuItem = MenuItem(
                              id: _editedMenuItem.id,
                              title: _editedMenuItem.title,
                              cuisine: _editedMenuItem.cuisine,
                              description: _editedMenuItem.description,
                              maxQuantity: value!,
                              veg: _editedMenuItem.veg,
                              discountOff: _editedMenuItem.discountOff,
                              price: _editedMenuItem.price,
                              image: _editedMenuItem.image,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['veg'],
                          decoration: InputDecoration(labelText: 'Veg'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          focusNode: _vegFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_discountFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The Veg must not be empty.';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedMenuItem = MenuItem(
                              id: _editedMenuItem.id,
                              title: _editedMenuItem.title,
                              cuisine: _editedMenuItem.cuisine,
                              description: _editedMenuItem.description,
                              maxQuantity: _editedMenuItem.maxQuantity,
                              veg: (String.fromEnvironment(value!) == "true")
                                  ? true
                                  : (String.fromEnvironment(value) == "false")
                                      ? false
                                      : false,
                              discountOff: _editedMenuItem.discountOff,
                              price: _editedMenuItem.price,
                              image: _editedMenuItem.image,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['discountOff'],
                          decoration:
                              InputDecoration(labelText: 'Discount Off'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _discountFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The Discount Off must not be empty.';
                            }
                            if (int.tryParse(value) == null) {
                              return 'The Discount Off must be in a number format.';
                            }
                            if (int.parse(value) < 0) {
                              return 'The Discount Off should not be less than zero.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedMenuItem = MenuItem(
                              id: _editedMenuItem.id,
                              title: _editedMenuItem.title,
                              cuisine: _editedMenuItem.cuisine,
                              description: _editedMenuItem.description,
                              maxQuantity: _editedMenuItem.maxQuantity,
                              veg: _editedMenuItem.veg,
                              discountOff: int.parse(value!),
                              price: _editedMenuItem.price,
                              image: _editedMenuItem.image,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['price'],
                          decoration: InputDecoration(labelText: 'Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _priceFocusNode,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The price must not be empty.';
                            }
                            if (double.tryParse(value) == null) {
                              return 'The price must be in a number format.';
                            }
                            if (double.parse(value) <= 0) {
                              return 'The price should not be less than zero.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedMenuItem = MenuItem(
                              id: _editedMenuItem.id,
                              title: _editedMenuItem.title,
                              cuisine: _editedMenuItem.cuisine,
                              description: _editedMenuItem.description,
                              maxQuantity: _editedMenuItem.maxQuantity,
                              veg: _editedMenuItem.veg,
                              discountOff: _editedMenuItem.discountOff,
                              price: double.parse(value!),
                              image: _editedMenuItem.image,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kYellow,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MaterialButton(
                    elevation: 5,
                    onPressed: () {
                      _saveForm();
                    },
                    child: Text(
                      "Edit Food Item",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path; 
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ibm_watson/flutter_ibm_watson.dart';

import '../providers/post.dart';
import '../providers/posts.dart';

class EditPostScreen extends StatefulWidget {
  static const routeName = '/edit-post';

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _phoneFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedPost = Post(
    id: null,
    name: '',
    phone: '',
    description: '',
    imageUrl: '',
    location: ''
  );
  var _initValues = {
    'name': '',
    'description': '',
    'phone': '',
    'imageUrl': '',
    'location': ''
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final postId = ModalRoute.of(context).settings.arguments as String;
      if (postId != null) {
        _editedPost =
            Provider.of<Posts>(context, listen: false).findById(postId);
        _initValues = {
          'name': _editedPost.name,
          'description': _editedPost.description,
          'phone': _editedPost.phone,
           'location': _editedPost.location,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedPost.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _phoneFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedPost.id != null) {
      await Provider.of<Posts>(context, listen: false)
          .updatePost(_editedPost.id, _editedPost);
    } else {
      try {
        await Provider.of<Posts>(context, listen: false)
            .addPost(_editedPost);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occurred!'),
                content: Text('Something went wrong.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
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
        title: Text('Edit Post'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_phoneFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPost = Post(
                            name: value,
                            location: _editedPost.location,
                            phone: _editedPost.phone,
                            description: _editedPost.description,
                            imageUrl: _editedPost.imageUrl,
                            id: _editedPost.id,
                            );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['phone'],
                      decoration: InputDecoration(labelText: 'Phone'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _phoneFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a phone.';
                        }
                        if (value == null) {
                          return 'Please enter a valid number.';
                        }
                        if (value.length <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPost = Post(
                            name: _editedPost.name,
                            location: _editedPost.location,
                            phone: value,
                            description: _editedPost.description,
                            imageUrl: _editedPost.imageUrl,
                            id: _editedPost.id,
                            );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPost = Post(
                          name: _editedPost.name,
                          location: _editedPost.location,
                          phone: _editedPost.phone,
                          description: value,
                          imageUrl: _editedPost.imageUrl,
                          id: _editedPost.id,
                         
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['location'],
                      decoration: InputDecoration(labelText: 'Location'),
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      focusNode: _locationFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a location.';
                        }
                        if (value.length < 5) {
                          return 'Should be at least 5 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPost = Post(
                          name: _editedPost.name,
                          location: value,
                          phone: _editedPost.phone,
                          description: _editedPost.description,
                          imageUrl: _editedPost.imageUrl,
                          id: _editedPost.id,
                         
                        );
                      },
                    ),
                    SizedBox(height: 15,),
                           Text('Selected Image'),  
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,                           
                            focusNode: _imageUrlFocusNode,
                           
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (_uploadedFileURL) {
                              if (_uploadedFileURL.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              // if (!_uploadedFileURL.startsWith('http') &&
                              //     !_uploadedFileURL.startsWith('https')) {
                              //   return 'Please enter a valid URL.';
                              // }
                              // if (!_uploadedFileURL.endsWith('.png') &&
                              //     !_uploadedFileURL.endsWith('.jpg') &&
                              //     !_uploadedFileURL.endsWith('.jpeg')) {
                              //   return 'Please enter a valid image URL.';
                              // }
                              return null;
                            },
                           
                            initialValue:  _image != null ? "${_image.path}" : "no image",
                            onSaved: (_uploadedFileURL) {
                              _editedPost = Post(
                                name: _editedPost.name,
                                location: _editedPost.location,
                                phone: _editedPost.phone,
                                description: _editedPost.description,
                                imageUrl: _uploadedFileURL,
                                id: _editedPost.id,
                                
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Text('Selected Image'),    
           _image != null    
               ? Image.asset(    
                   _image.path,    
                   height: 150,    
                 )    
               : Container(height: 150),    
           _image == null    
               ? RaisedButton(    
                   child: Text('Choose File'),    
                   onPressed: chooseFile,    
                   color: Colors.cyan,    
                 )    
               : Container(),    
           _image != null    
               ? RaisedButton(    
                   child: Text('Upload File'),    
                   onPressed: uploadFile,    
                   color: Colors.cyan,    
                 )    
               : Container(),    
              
                Container(),    
           Text('Uploaded Image'),    
           _uploadedFileURL != null    
               ? Image.network(    
                   _uploadedFileURL,    
                   height: 150,    
                 )    
               : Container(),    
         ],    
          
     ),    
        
      ),
                  
                ),
              
            
    );
  }
  File _image;
  String _uploadedFileURL;

 Future chooseFile() async {    
   await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
     setState(() {    
       _image = image;    
     });    
   });    
 } 
  
   
   

 Future uploadFile() async {    
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('chats/${Path.basename(_image.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(_image);    
   await uploadTask.onComplete;    
   print('File Uploaded');    
   storageReference.getDownloadURL().then((fileURL) {    
     setState(() {    
       _uploadedFileURL = fileURL;    
     });   
     print(_uploadedFileURL); 
   });    
 }   

//  void visualRecognitionFile(File image) async {
//     IamOptions options = await IamOptions(iamApiKey: "hV296MO0aaL-z8XT3CaaFsq_5JJB0XWJyJY-TU8WzXxI", url: "https://gateway.watsonplatform.net/visual-recognition/api").build();
//     VisualRecognition visualRecognition = new VisualRecognition(
//         iamOptions: options, language: Language.ENGLISH);
//     ClassifiedImages classifiedImages =
//         await visualRecognition.classifyImageFile(image.path);

//     print(classifiedImages
//         .getImages()[0]
//         .getClassifiers()[0]
//         .getClasses()[0]
//         .className);
// }
}

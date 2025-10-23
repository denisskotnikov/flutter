import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:html' as html;
import '../models/product.dart';
import '../bloc/product_cubit.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _articleController = TextEditingController();
  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();
  final _priceController = TextEditingController();
  
  String _imageUrl = 'https://via.placeholder.com/150';
  String _fileName = 'Файл не выбран';

  void _pickImage() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();
        
        reader.onLoadEnd.listen((e) {
          setState(() {
            _imageUrl = reader.result as String;
            _fileName = file.name;
          });
        });
        
        reader.readAsDataUrl(file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить товар'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Превью изображения
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _imageUrl.isNotEmpty
                      ? Image.network(
                          _imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Нажмите для выбора изображения'),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Информация о выбранном файле
              Card(
                child: ListTile(
                  leading: const Icon(Icons.attach_file),
                  title: Text(_fileName),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _imageUrl = 'https://via.placeholder.com/150';
                        _fileName = 'Файл не выбран';
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Кнопка выбора файла
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_library),
                label: const Text('Выбрать файл изображения'),
              ),
              const SizedBox(height: 24),

              // Остальные поля формы
              TextFormField(
                controller: _articleController,
                decoration: const InputDecoration(
                  labelText: 'Артикул *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.confirmation_number),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите артикул';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Наименование *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите наименование';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _sizeController,
                decoration: const InputDecoration(
                  labelText: 'Размер',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.straighten),
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Цена',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              
              // Кнопка добавления
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final product = Product(
                      article: _articleController.text,
                      name: _nameController.text,
                      size: _sizeController.text,
                      price: double.tryParse(_priceController.text) ?? 0.0,
                      imageUrl: _imageUrl,
                    );
                    
                    context.read<ProductCubit>().addProduct(product);
                    Navigator.pop(context);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Товар успешно добавлен'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Добавить товар',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _articleController.dispose();
    _nameController.dispose();
    _sizeController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
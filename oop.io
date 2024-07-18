import 'dart:convert';
import 'dart:io';

// Interface
abstract class CanMakeSound {
  void makeSound();
}

// Base class
class Animal {
  String name;
  int age;

  Animal(this.name, this.age);

  void makeSound() {
    print('$name makes a sound.');
  }
}

// Derived class implementing interface and overriding method
class Dog extends Animal implements CanMakeSound {
  String breed;

  Dog(String name, int age, this.breed) : super(name, age);

  @override
  void makeSound() {
    print('$name barks.');
  }

  // Method that demonstrates the use of a loop
  void displaySounds(int times) {
    for (int i = 0; i < times; i++) {
      makeSound();
    }
  }
}

// Function to read data from a file and initialize a Dog instance
Future<Dog> readDogFromFile(String filePath) async {
  final file = File(filePath);
  final contents = await file.readAsString();
  final data = jsonDecode(contents);

  return Dog(data['name'], data['age'], data['breed']);
}

void main() async {
  // Path to the data file
  final filePath = 'dog_data.json';

  try {
    // Read dog data from the file and create a Dog instance
    Dog myDog = await readDogFromFile(filePath);

    // Display information and sounds
    print('Dog Name: ${myDog.name}');
    print('Dog Age: ${myDog.age}');
    print('Dog Breed: ${myDog.breed}');

    // Demonstrate the use of a loop
    myDog.displaySounds(3);
  } catch (e) {
    print('Error: $e');
  }
}

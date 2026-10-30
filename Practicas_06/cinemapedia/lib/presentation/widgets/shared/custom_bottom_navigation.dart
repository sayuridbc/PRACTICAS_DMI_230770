import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
	const CustomBottomNavigation({super.key});

	@override
	Widget build(BuildContext context) {
		return NavigationBar(
			selectedIndex: 0,
			destinations: const [
				NavigationDestination(
					icon: Icon(Icons.home_outlined),
					selectedIcon: Icon(Icons.home),
					label: 'Inicio',
				),
				NavigationDestination(
					icon: Icon(Icons.search),
					label: 'Buscar',
				),
				NavigationDestination(
					icon: Icon(Icons.favorite_outline),
					selectedIcon: Icon(Icons.favorite),
					label: 'Favoritos',
				),
			],
		);
	}
}

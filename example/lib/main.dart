import 'package:flutter/material.dart';
import 'package:shipit_ui/shipit_ui.dart';

void main() {
  runApp(const ShipitCatalogApp());
}

class ShipitCatalogApp extends StatelessWidget {
  const ShipitCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shipit_ui Catalog',
      theme: shipitLightTheme(),
      darkTheme: shipitDarkTheme(),
      home: const CatalogHomePage(),
    );
  }
}

class CatalogHomePage extends StatelessWidget {
  const CatalogHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('shipit_ui Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section('Buttons'),
          _ButtonShowcase(),
          _Section('Text Fields'),
          _TextFieldShowcase(),
          _Section('Select'),
          _SelectShowcase(),
          _Section('Cards'),
          _CardShowcase(),
          _Section('Dialog'),
          _DialogShowcase(),
          _Section('States'),
          _LoadingStateShowcase(),
          _EmptyStateShowcase(),
          _ErrorStateShowcase(),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  const _Section(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _ButtonShowcase extends StatelessWidget {
  const _ButtonShowcase();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        AppButton.primary(label: 'Primary'),
        AppButton.secondary(label: 'Secondary'),
        AppButton.destructive(label: 'Destructive'),
        AppButton.ghost(label: 'Ghost'),
        AppButton.primary(label: 'Loading', isLoading: true),
        AppButton.primary(label: 'Disabled', isDisabled: true),
      ],
    );
  }
}

class _TextFieldShowcase extends StatelessWidget {
  const _TextFieldShowcase();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField.normal(label: 'Name', hint: 'Enter name'),
        const SizedBox(height: 8),
        AppTextField.error(label: 'Email', errorMessage: 'Invalid'),
        const SizedBox(height: 8),
        AppTextField.disabled(label: 'Status', value: 'Active'),
      ],
    );
  }
}

class _SelectShowcase extends StatelessWidget {
  const _SelectShowcase();

  @override
  Widget build(BuildContext context) {
    return AppSelect<String>(
      label: 'Category',
      options: const [
        AppSelectOption(value: 'a', label: 'Option A'),
        AppSelectOption(value: 'b', label: 'Option B'),
        AppSelectOption(value: 'c', label: 'Option C'),
      ],
      onChanged: (value) {},
    );
  }
}

class _CardShowcase extends StatelessWidget {
  const _CardShowcase();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      title: 'Sample Card',
      subtitle: 'Card subtitle',
      trailing: const Icon(Icons.chevron_right),
      children: [const Text('Card content goes here')],
    );
  }
}

class _DialogShowcase extends StatelessWidget {
  const _DialogShowcase();

  @override
  Widget build(BuildContext context) {
    return AppButton.primary(
      label: 'Show Dialog',
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => AppDialog(
            title: 'Confirm Action',
            subtitle: 'Please review the details',
            content: const Text('Are you sure you want to proceed?'),
            actions: [
              AppButton.ghost(
                label: 'Cancel',
                onPressed: () => Navigator.pop(ctx),
              ),
              AppButton.primary(
                label: 'Confirm',
                onPressed: () => Navigator.pop(ctx),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LoadingStateShowcase extends StatelessWidget {
  const _LoadingStateShowcase();

  @override
  Widget build(BuildContext context) {
    return AppLoadingState(message: 'Loading data...');
  }
}

class _EmptyStateShowcase extends StatelessWidget {
  const _EmptyStateShowcase();

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      title: 'No Items',
      message: 'Create one to get started',
      actionLabel: 'Create',
      onAction: () {},
    );
  }
}

class _ErrorStateShowcase extends StatelessWidget {
  const _ErrorStateShowcase();

  @override
  Widget build(BuildContext context) {
    return AppErrorState(
      title: 'Something Went Wrong',
      message: 'Failed to load data',
      onRetry: () {},
    );
  }
}

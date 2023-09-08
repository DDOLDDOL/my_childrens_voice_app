import 'package:flutter/material.dart';

class MessageInputForm extends StatefulWidget {
  const MessageInputForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final void Function(String) onSubmit;

  @override
  State<MessageInputForm> createState() => _MessageInputFormState();
}

class _MessageInputFormState extends State<MessageInputForm> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _InputField(
              controller: _controller,
              onSubmit: (value) {
                widget.onSubmit(value);
                _controller.clear();
              },
            ),
          ),
          _SendButton(
            onTap: () {
              widget.onSubmit(_controller.text);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    Key? key,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  final void Function(String) onSubmit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.send,
      onFieldSubmitted: onSubmit,
      style: const TextStyle(fontSize: 16),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        border: InputBorder.none,
        hintText: '보낼 메시지를 입력해주세요',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.teal.shade300,
        child: const Icon(Icons.send, size: 24, color: Colors.white),
      ),
    );
  }
}

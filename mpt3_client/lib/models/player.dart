// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Player {
  final double points;
  final String nickname;
  final String socketID;
  final String playerType;

  Player({
    required this.points,
    required this.nickname,
    required this.socketID,
    required this.playerType,
  });

  Player copyWith({
    double? points,
    String? nickname,
    String? socketID,
    String? playerType,
  }) {
    return Player(
      points: points ?? this.points,
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      playerType: playerType ?? this.playerType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'points': points,
      'nickname': nickname,
      'socketID': socketID,
      'playerType': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      points: map['points'] ?? 0.0,
      nickname: map['nickname'] ?? "",
      socketID: map['socketID'] ?? "",
      playerType: map['playerType'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) =>
      Player.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Player(nickname: $nickname, socketID: $socketID, points: $points, playerType: $playerType)';
  }

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;

    return other.nickname == nickname &&
        other.socketID == socketID &&
        other.points == points &&
        other.playerType == playerType;
  }

  @override
  int get hashCode {
    return nickname.hashCode ^
        socketID.hashCode ^
        points.hashCode ^
        playerType.hashCode;
  }
}

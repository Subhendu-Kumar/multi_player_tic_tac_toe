// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Player {
  final String nickname;
  final String socketID;
  final double points;
  final String playerType;

  Player({
    required this.nickname,
    required this.socketID,
    required this.points,
    required this.playerType,
  });

  Player copyWith({
    String? nickname,
    String? socketID,
    double? points,
    String? playerType,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickname': nickname,
      'socketID': socketID,
      'points': points,
      'playerType': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] ?? "",
      socketID: map['socketID'] ?? "",
      points: map['points'] ?? 0.0,
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

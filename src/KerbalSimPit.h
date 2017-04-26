#ifndef KerbalSimPit_h
#define KerbalSimPit_h

#include <Arduino.h>

#include "KerbalSimPitPacketTypes.h"
#include "PayloadStructs.h"

class KerbalSimPit
{
 public:
  KerbalSimPit(Stream &serial);
  bool init();
  void inboundHandler(void (*messageHandler)(byte messageType,
                                            byte msg[], byte msgSize));
  void registerChannel(byte channelID);
  void deregisterChannel(byte channelID);
  void send(byte messageType, byte msg[], byte msgSize);
  void update();

  // Helper functions
  void activateCAG(byte actiongroup);
  void deactivateCAG(byte actiongroup);
  void toggleCAG(byte actiongroup);
  void activateAction(byte action);
  void deactivateAction(byte action);
  void toggleAction(byte action);

 private:
  byte _readBuffer;
  byte _inboundType;
  byte _inboundSize;
  byte _inboundBuffer[32];
  byte _outboundBuffer[32];
  byte _outboundSize;
  Stream *_serial;

  enum ReceiveState_t
  {
    WaitingFirstByte,
    WaitingSecondByte,
    WaitingSize,
    WaitingType,
    WaitingData,
  };
  ReceiveState_t _receiveState;
  byte _receivedIndex;

  void (*_messageHandler)(byte messageType, byte msg[], byte msgSize);
};

#endif

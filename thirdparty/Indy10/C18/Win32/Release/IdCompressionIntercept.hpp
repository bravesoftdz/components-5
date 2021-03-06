// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'IdCompressionIntercept.pas' rev: 25.00 (Windows)

#ifndef IdcompressioninterceptHPP
#define IdcompressioninterceptHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <IdException.hpp>	// Pascal unit
#include <IdGlobal.hpp>	// Pascal unit
#include <IdGlobalProtocols.hpp>	// Pascal unit
#include <IdIntercept.hpp>	// Pascal unit
#include <IdTCPClient.hpp>	// Pascal unit
#include <IdTCPConnection.hpp>	// Pascal unit
#include <IdZLibHeaders.hpp>	// Pascal unit
#include <IdZLib.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <IdBaseComponent.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Idcompressionintercept
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EIdCompressionException;
#pragma pack(push,4)
class PASCALIMPLEMENTATION EIdCompressionException : public Idexception::EIdException
{
	typedef Idexception::EIdException inherited;
	
public:
	/* EIdException.Create */ inline __fastcall virtual EIdCompressionException(const System::UnicodeString AMsg)/* overload */ : Idexception::EIdException(AMsg) { }
	
public:
	/* Exception.CreateFmt */ inline __fastcall EIdCompressionException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Idexception::EIdException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EIdCompressionException(NativeUInt Ident)/* overload */ : Idexception::EIdException(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EIdCompressionException(System::PResStringRec ResStringRec)/* overload */ : Idexception::EIdException(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EIdCompressionException(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Idexception::EIdException(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall EIdCompressionException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : Idexception::EIdException(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EIdCompressionException(const System::UnicodeString Msg, int AHelpContext) : Idexception::EIdException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EIdCompressionException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Idexception::EIdException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIdCompressionException(NativeUInt Ident, int AHelpContext)/* overload */ : Idexception::EIdException(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIdCompressionException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : Idexception::EIdException(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIdCompressionException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Idexception::EIdException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIdCompressionException(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Idexception::EIdException(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EIdCompressionException(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS EIdCompressorInitFailure;
#pragma pack(push,4)
class PASCALIMPLEMENTATION EIdCompressorInitFailure : public EIdCompressionException
{
	typedef EIdCompressionException inherited;
	
public:
	/* EIdException.Create */ inline __fastcall virtual EIdCompressorInitFailure(const System::UnicodeString AMsg)/* overload */ : EIdCompressionException(AMsg) { }
	
public:
	/* Exception.CreateFmt */ inline __fastcall EIdCompressorInitFailure(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : EIdCompressionException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EIdCompressorInitFailure(NativeUInt Ident)/* overload */ : EIdCompressionException(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EIdCompressorInitFailure(System::PResStringRec ResStringRec)/* overload */ : EIdCompressionException(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EIdCompressorInitFailure(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : EIdCompressionException(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall EIdCompressorInitFailure(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : EIdCompressionException(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EIdCompressorInitFailure(const System::UnicodeString Msg, int AHelpContext) : EIdCompressionException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EIdCompressorInitFailure(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : EIdCompressionException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIdCompressorInitFailure(NativeUInt Ident, int AHelpContext)/* overload */ : EIdCompressionException(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIdCompressorInitFailure(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : EIdCompressionException(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIdCompressorInitFailure(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : EIdCompressionException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIdCompressorInitFailure(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : EIdCompressionException(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EIdCompressorInitFailure(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS EIdDecompressorInitFailure;
#pragma pack(push,4)
class PASCALIMPLEMENTATION EIdDecompressorInitFailure : public EIdCompressionException
{
	typedef EIdCompressionException inherited;
	
public:
	/* EIdException.Create */ inline __fastcall virtual EIdDecompressorInitFailure(const System::UnicodeString AMsg)/* overload */ : EIdCompressionException(AMsg) { }
	
public:
	/* Exception.CreateFmt */ inline __fastcall EIdDecompressorInitFailure(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : EIdCompressionException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EIdDecompressorInitFailure(NativeUInt Ident)/* overload */ : EIdCompressionException(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EIdDecompressorInitFailure(System::PResStringRec ResStringRec)/* overload */ : EIdCompressionException(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EIdDecompressorInitFailure(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : EIdCompressionException(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall EIdDecompressorInitFailure(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : EIdCompressionException(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EIdDecompressorInitFailure(const System::UnicodeString Msg, int AHelpContext) : EIdCompressionException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EIdDecompressorInitFailure(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : EIdCompressionException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIdDecompressorInitFailure(NativeUInt Ident, int AHelpContext)/* overload */ : EIdCompressionException(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIdDecompressorInitFailure(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : EIdCompressionException(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIdDecompressorInitFailure(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : EIdCompressionException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIdDecompressorInitFailure(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : EIdCompressionException(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EIdDecompressorInitFailure(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS EIdCompressionError;
#pragma pack(push,4)
class PASCALIMPLEMENTATION EIdCompressionError : public EIdCompressionException
{
	typedef EIdCompressionException inherited;
	
public:
	/* EIdException.Create */ inline __fastcall virtual EIdCompressionError(const System::UnicodeString AMsg)/* overload */ : EIdCompressionException(AMsg) { }
	
public:
	/* Exception.CreateFmt */ inline __fastcall EIdCompressionError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : EIdCompressionException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EIdCompressionError(NativeUInt Ident)/* overload */ : EIdCompressionException(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EIdCompressionError(System::PResStringRec ResStringRec)/* overload */ : EIdCompressionException(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EIdCompressionError(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : EIdCompressionException(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall EIdCompressionError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : EIdCompressionException(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EIdCompressionError(const System::UnicodeString Msg, int AHelpContext) : EIdCompressionException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EIdCompressionError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : EIdCompressionException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIdCompressionError(NativeUInt Ident, int AHelpContext)/* overload */ : EIdCompressionException(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIdCompressionError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : EIdCompressionException(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIdCompressionError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : EIdCompressionException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIdCompressionError(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : EIdCompressionException(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EIdCompressionError(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS EIdDecompressionError;
#pragma pack(push,4)
class PASCALIMPLEMENTATION EIdDecompressionError : public EIdCompressionException
{
	typedef EIdCompressionException inherited;
	
public:
	/* EIdException.Create */ inline __fastcall virtual EIdDecompressionError(const System::UnicodeString AMsg)/* overload */ : EIdCompressionException(AMsg) { }
	
public:
	/* Exception.CreateFmt */ inline __fastcall EIdDecompressionError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : EIdCompressionException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EIdDecompressionError(NativeUInt Ident)/* overload */ : EIdCompressionException(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EIdDecompressionError(System::PResStringRec ResStringRec)/* overload */ : EIdCompressionException(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EIdDecompressionError(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : EIdCompressionException(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall EIdDecompressionError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : EIdCompressionException(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EIdDecompressionError(const System::UnicodeString Msg, int AHelpContext) : EIdCompressionException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EIdDecompressionError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : EIdCompressionException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIdDecompressionError(NativeUInt Ident, int AHelpContext)/* overload */ : EIdCompressionException(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIdDecompressionError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : EIdCompressionException(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIdDecompressionError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : EIdCompressionException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIdDecompressionError(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : EIdCompressionException(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EIdDecompressionError(void) { }
	
};

#pragma pack(pop)

typedef System::Int8 TIdCompressionLevel;

class DELPHICLASS TIdCompressionIntercept;
class PASCALIMPLEMENTATION TIdCompressionIntercept : public Idintercept::TIdConnectionIntercept
{
	typedef Idintercept::TIdConnectionIntercept inherited;
	
protected:
	TIdCompressionLevel FCompressionLevel;
	z_stream FCompressRec;
	z_stream FDecompressRec;
	Idglobal::TIdBytes FRecvBuf;
	unsigned FRecvCount;
	unsigned FRecvSize;
	Idglobal::TIdBytes FSendBuf;
	unsigned FSendCount;
	unsigned FSendSize;
	void __fastcall SetCompressionLevel(TIdCompressionLevel Value);
	void __fastcall InitCompressors(void);
	void __fastcall DeinitCompressors(void);
	
public:
	__fastcall virtual ~TIdCompressionIntercept(void);
	virtual void __fastcall Disconnect(void);
	virtual void __fastcall Receive(Idglobal::TIdBytes &VBuffer);
	virtual void __fastcall Send(Idglobal::TIdBytes &VBuffer);
	
__published:
	__property TIdCompressionLevel CompressionLevel = {read=FCompressionLevel, write=SetCompressionLevel, nodefault};
public:
	/* TIdBaseComponent.Create */ inline __fastcall TIdCompressionIntercept(System::Classes::TComponent* AOwner)/* overload */ : Idintercept::TIdConnectionIntercept(AOwner) { }
	
public:
	/* TIdInitializerComponent.Create */ inline __fastcall TIdCompressionIntercept(void)/* overload */ : Idintercept::TIdConnectionIntercept() { }
	
};


class DELPHICLASS TIdServerCompressionIntercept;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TIdServerCompressionIntercept : public Idintercept::TIdServerIntercept
{
	typedef Idintercept::TIdServerIntercept inherited;
	
protected:
	TIdCompressionLevel FCompressionLevel;
	
public:
	virtual void __fastcall Init(void);
	virtual Idintercept::TIdConnectionIntercept* __fastcall Accept(System::Classes::TComponent* AConnection);
	
__published:
	__property TIdCompressionLevel CompressionLevel = {read=FCompressionLevel, write=FCompressionLevel, nodefault};
public:
	/* TIdBaseComponent.Create */ inline __fastcall TIdServerCompressionIntercept(System::Classes::TComponent* AOwner)/* overload */ : Idintercept::TIdServerIntercept(AOwner) { }
	
public:
	/* TIdInitializerComponent.Create */ inline __fastcall TIdServerCompressionIntercept(void)/* overload */ : Idintercept::TIdServerIntercept() { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TIdServerCompressionIntercept(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Idcompressionintercept */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_IDCOMPRESSIONINTERCEPT)
using namespace Idcompressionintercept;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IdcompressioninterceptHPP

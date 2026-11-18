/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.zlib

import ohos.ffi.CArrString

foreign {
    func FfiBundleManagerCompressFile(inFile: CString, outFile: CString, options: RetOptions): Int32

    func FfiBundleManagerDeCompressFileOptions(inFile: CString, outFile: CString, options: RetOptions): Int32

    func FfiBundleManagerDeCompressFile(inFile: CString, outFile: CString): Int32

    func FfiBundleManagerCompressFiles(args: CArrString, outFile: CString, options: RetOptions): Int32

    func FfiBundleManagerGetOriginalSize(compressedFile: CString, errCode: CPointer<Int32>): Int64

    func FfiBundleManagerZipInstCreate(): UIntNative

    func FfiBundleManagerZipInstDestroy(ffiInst: UIntNative): Unit

    func FfiBundleManagerZipCompress(ffiInst: UIntNative, param: CPointer<ZipCompressParam>,
        errCode: CPointer<Int32>): Unit

    func FfiBundleManagerZipCompress2(ffiInst: UIntNative, param: CPointer<ZipCompressParam>,
        errCode: CPointer<Int32>): Unit

    func FfiBundleManagerZipCompressBound(ffiInst: UIntNative, sourceLen: Int32, errCode: CPointer<Int32>): Int32

    func FfiBundleManagerZipGetZStream(ffiInst: UIntNative, cStrm: CPointer<CZStream>, errCode: CPointer<Int32>): Unit

    func FfiBundleManagerZipDeflate(ffiInst: UIntNative, cStrm: CPointer<CZStream>, flush: Int32,
        errCode: CPointer<Int32>): Int32

    func FfiBundleManagerZipDeflateEnd(ffiInst: UIntNative, cStrm: CPointer<CZStream>,
        errCode: CPointer<Int32>): Int32

    func FfiBundleManagerZipDeflateInit2(ffiInst: UIntNative, cStrm: CPointer<CZStream>,
        param: CPointer<DeflateInit2Param>, errCode: CPointer<Int32>): Int32

    func FfiBundleManagerZipInflate(ffiInst: UIntNative, cStrm: CPointer<CZStream>, flush: Int32,
        errCode: CPointer<Int32>): Int32

    func FfiBundleManagerZipInflateEnd(ffiInst: UIntNative, cStrm: CPointer<CZStream>,
        errCode: CPointer<Int32>): Int32

    func FfiBundleManagerZipInflateInit(ffiInst: UIntNative, cStrm: CPointer<CZStream>,
        errCode: CPointer<Int32>): Int32

    func FfiBundleManagerZipInflateInit2(ffiInst: UIntNative, cStrm: CPointer<CZStream>, windowBits: Int32,
        errCode: CPointer<Int32>): Int32

    func FfiBundleManagerZipUnCompress(ffiInst: UIntNative, param: CPointer<ZipCompressParam>,
        errCode: CPointer<Int32>): Unit

    func FfiBundleManagerChecksumInstCreate(): UIntNative

    func FfiBundleManagerChecksumInstDestroy(ffiInst: UIntNative): Unit

    func FfiBundleManagerChecksumCrc32(ffiInst: UIntNative, crc: UInt64, buf: CPointer<Byte>, len: UInt64,
        errCode: CPointer<Int32>): UInt64

    func FfiBundleManagerGZipInstCreate(): UIntNative

    func FfiBundleManagerGZipInstDestroy(ffiInst: UIntNative): Unit

    func FfiBundleManagerGZipDopen(ffiInst: UIntNative, fd: Int32, mode: CString, errCode: CPointer<Int32>): Unit

    func FfiBundleManagerGZipOpen(ffiInst: UIntNative, path: CString, mode: CString,
        errCode: CPointer<Int32>): Unit

    func FfiBundleManagerGZipEof(ffiInst: UIntNative, errCode: CPointer<Int32>): Int32

    func FfiBundleManagerGZipClose(ffiInst: UIntNative, errCode: CPointer<Int32>): Int32

    func FfiBundleManagerGZipWrite(ffiInst: UIntNative, buf: CPointer<Byte>, len: Int64,
        errCode: CPointer<Int32>): Int64

    func FfiBundleManagerGZipRead(ffiInst: UIntNative, buf: CPointer<Byte>, len: Int64,
        errCode: CPointer<Int32>): Int64

    func FfiBundleManagerGZipPuts(ffiInst: UIntNative, cstr: CString, errCode: CPointer<Int32>): Int32

    func FfiBundleManagerGZipGets(ffiInst: UIntNative, buf: CPointer<Byte>, len: Int64,
        errCode: CPointer<Int32>): CString
}

// zlib default values used when the corresponding Options field is None.
const ZLIB_DEFAULT_COMPRESSION_LEVEL: Int32 = -1
const ZLIB_DEFAULT_MEM_LEVEL: Int32 = 8
const ZLIB_DEFAULT_STRATEGY: Int32 = 0

@C
struct RetOptions {
    let level: Int32
    let memLevel: Int32
    let strategy: Int32

    init(options: Options) {
        this.level = match (options.level) {
            case Some(v) => v.getValue()
            case None => ZLIB_DEFAULT_COMPRESSION_LEVEL
        }
        this.memLevel = match (options.memLevel) {
            case Some(v) => v.getValue()
            case None => ZLIB_DEFAULT_MEM_LEVEL
        }
        this.strategy = match (options.strategy) {
            case Some(v) => v.getValue()
            case None => ZLIB_DEFAULT_STRATEGY
        }
    }
}

@C
struct ZipCompressParam {
    var destBuf: CPointer<Byte> = CPointer<Byte>()
    var destBufLen: Int64 = 0
    var srcBuf: CPointer<Byte> = CPointer<Byte>()
    var srcBufLen: Int64 = 0
    var outStatus: Int32 = 0
    var outDestLen: Int64 = 0
    var level: Int32 = 0

    init() {}
}

@C
struct CZStream {
    var nextIn: CPointer<Byte> = CPointer<Byte>()
    var availableIn: UInt32 = 0
    var totalIn: UInt64 = 0
    var nextOut: CPointer<Byte> = CPointer<Byte>()
    var availableOut: UInt32 = 0
    var totalOut: UInt64 = 0
    var dataType: Int32 = 0
    var adler: UInt64 = 0

    var hasNextIn: Bool = false
    var hasAvailableIn: Bool = false
    var hasTotalIn: Bool = false
    var hasNextOut: Bool = false
    var hasAvailableOut: Bool = false
    var hasTotalOut: Bool = false
    var hasDataType: Bool = false
    var hasAdler: Bool = false

    init() {}

    // Converts a ZStream into this C struct and acquires the raw data pointers of its buffers.
    // Caution: must directly call destroyRawPtr after the FFI call completes.
    mut unsafe func initWithRawPtr(strm: ZStream): (CPointerHandle<Byte>, CPointerHandle<Byte>) {
        let nextInVp: CPointerHandle<Byte>
        let nextOutVp: CPointerHandle<Byte>
        if (let Some(v) <- strm.nextIn) {
            nextInVp = acquireArrayRawData(v)
            nextIn = nextInVp.pointer
            hasNextIn = true
        } else {
            nextInVp = CPointerHandle<Byte>()
        }
        if (let Some(v) <- strm.nextOut) {
            nextOutVp = acquireArrayRawData(v)
            nextOut = nextOutVp.pointer
            hasNextOut = true
        } else {
            nextOutVp = CPointerHandle<Byte>()
        }
        if (let Some(v) <- strm.availableIn) {
            availableIn = v
            hasAvailableIn = true
        }
        if (let Some(v) <- strm.totalIn) {
            totalIn = v
            hasTotalIn = true
        }
        if (let Some(v) <- strm.availableOut) {
            availableOut = v
            hasAvailableOut = true
        }
        if (let Some(v) <- strm.totalOut) {
            totalOut = v
            hasTotalOut = true
        }
        if (let Some(v) <- strm.dataType) {
            dataType = v
            hasDataType = true
        }
        if (let Some(v) <- strm.adler) {
            adler = v
            hasAdler = true
        }
        return (nextInVp, nextOutVp)
    }

    // Caution: nextInVp and nextOutVp must come from initWithRawPtr.
    mut unsafe func destroyRawPtr(nextInVp: CPointerHandle<Byte>, nextOutVp: CPointerHandle<Byte>): Unit {
        if (hasNextIn) {
            releaseArrayRawData(nextInVp)
            nextIn = CPointer<Byte>()
        }
        if (hasNextOut) {
            releaseArrayRawData(nextOutVp)
            nextOut = CPointer<Byte>()
        }
    }
}

@C
struct DeflateInit2Param {
    let level: Int32
    let method: Int32
    let windowBits: Int32
    let memLevel: Int32
    let strategy: Int32

    init(level: Int32, method: Int32, windowBits: Int32, memLevel: Int32, strategy: Int32) {
        this.level = level
        this.method = method
        this.windowBits = windowBits
        this.memLevel = memLevel
        this.strategy = strategy
    }
}

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

import ohos.business_exception.{AsyncCallback, BusinessException, getUniversalErrorMsg}
import ohos.ffi.SUCCESS_CODE
import ohos.labels.APILevel

public type ArrayBuffer = Array<Byte>

class ZipOutputInfoImpl {
    var status_: ReturnStatus
    var destLen_: Int64

    init(status: ReturnStatus, destLen: Int64) {
        this.status_ = status
        this.destLen_ = destLen
    }
}

/**
 * Compression and decompression return value information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class ZipOutputInfo {
    private var zipOutputInfoImpl: ZipOutputInfoImpl

    /**
     * For details, see ReturnStatus.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop status: ReturnStatus {
        get() {
            return zipOutputInfoImpl.status_
        }
        set(value) {
            zipOutputInfoImpl.status_ = value
        }
    }

    /**
     * Total length of the destination buffer.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public mut prop destLen: Int64 {
        get() {
            return zipOutputInfoImpl.destLen_
        }
        set(value) {
            zipOutputInfoImpl.destLen_ = value
        }
    }

    init(status: ReturnStatus, destLen: Int64) {
        this.zipOutputInfoImpl = ZipOutputInfoImpl(status, destLen)
    }
}

class ZipImpl {
    let ffiInst_: UIntNative

    init() {
        this.ffiInst_ = unsafe { FfiBundleManagerZipInstCreate() }
    }

    ~init() {
        unsafe { FfiBundleManagerZipInstDestroy(this.ffiInst_) }
    }

    prop id: UIntNative {
        get() {
            return ffiInst_
        }
    }
}

/**
 * Defines the **Zip** instance. It provides APIs to zip or unzip data in Zlib, Deflate, or Gzip format.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class Zip {
    private var zipImpl: ZipImpl

    init() {
        this.zipImpl = ZipImpl()
    }

    /**
     * Obtains this stream. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<ZStream> } callback - Callback used to return the **ZStream** object.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public func getZStream(callback: AsyncCallback<ZStream>): Unit {
        spawn {
            var errCode: Int32 = 0
            var cStrm = CZStream()
            unsafe { FfiBundleManagerZipGetZStream(zipImpl.id, inout cStrm, inout errCode) }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ZStream.parse(cStrm)))
        }
    }

    /**
     * Compresses the source buffer into the destination buffer. This API uses an asynchronous callback to return the
     * result.
     *
     * @param { ArrayBuffer } dest - Destination buffer.
     * @param { ArrayBuffer } source - Source buffer.
     * @param { AsyncCallback<ZipOutputInfo> } callback - Callback used to return the result status and the total size
     *     of the destination buffer.
     * @param { ?Int64 } [sourceLen] - Length of the source data. The default value is **0**.
     * @throws { BusinessException } 17800007 - The input buffer is incorrect, and the output buffer is too small to
     *     accommodate the compressed or decompressed data.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func compress(dest: ArrayBuffer, source: ArrayBuffer, callback: AsyncCallback<ZipOutputInfo>,
        sourceLen!: ?Int64 = None): Unit {
        spawn {
            let srcLen = match (sourceLen) {
                case Some(v) => v
                case None => 0
            }
            if (srcLen > source.size || srcLen < 0) {
                invokeAsyncCallbackParamError(callback, "compress")
                return
            }
            let trueSrcSize = if (srcLen == 0) {
                source.size
            } else {
                srcLen
            }
            var errCode: Int32 = 0
            let vpDest = unsafe { acquireArrayRawData(dest) }
            let vpSource = unsafe { acquireArrayRawData(source) }
            var param = ZipCompressParam()
            param.destBuf = vpDest.pointer
            param.destBufLen = dest.size
            param.srcBuf = vpSource.pointer
            param.srcBufLen = trueSrcSize
            unsafe {
                FfiBundleManagerZipCompress(zipImpl.id, inout param, inout errCode)
                releaseArrayRawData(vpDest)
                releaseArrayRawData(vpSource)
            }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ZipOutputInfo(ReturnStatus.parse(param.outStatus), param.outDestLen)))
        }
    }

    /**
     * Compresses the source buffer into the destination buffer. This API uses an asynchronous callback to return the
     * result.
     *
     * @param { ArrayBuffer } dest - Destination buffer.
     * @param { ArrayBuffer } source - Source buffer.
     * @param { CompressLevel } level - For details, see CompressLevel.
     * @param { AsyncCallback<ZipOutputInfo> } callback - Callback used to return the result status and the total size
     *     of the destination buffer.
     * @param { ?Int64 } [sourceLen] - Length of the source data. The default value is **0**.
     * @throws { BusinessException } 17800004 - Compression or decompression stream error, which may be caused by an
     *     initialization error in the zlib stream structure or a modified structure.
     * @throws { BusinessException } 17800007 - The input buffer is incorrect, and the output buffer is too small to
     *     accommodate the compressed or decompressed data.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func compress2(dest: ArrayBuffer, source: ArrayBuffer, level: CompressLevel,
        callback: AsyncCallback<ZipOutputInfo>, sourceLen!: ?Int64 = None): Unit {
        spawn {
            let srcLen = match (sourceLen) {
                case Some(v) => v
                case None => 0
            }
            if (srcLen > source.size || srcLen < 0) {
                invokeAsyncCallbackParamError(callback, "compress2")
                return
            }
            let trueSrcSize = if (srcLen == 0) {
                source.size
            } else {
                srcLen
            }
            var errCode: Int32 = 0
            let vpDest = unsafe { acquireArrayRawData(dest) }
            let vpSource = unsafe { acquireArrayRawData(source) }
            var param = ZipCompressParam()
            param.destBuf = vpDest.pointer
            param.destBufLen = dest.size
            param.srcBuf = vpSource.pointer
            param.srcBufLen = trueSrcSize
            param.level = level.getValue()
            unsafe {
                FfiBundleManagerZipCompress2(zipImpl.id, inout param, inout errCode)
                releaseArrayRawData(vpDest)
                releaseArrayRawData(vpSource)
            }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ZipOutputInfo(ReturnStatus.parse(param.outStatus), param.outDestLen)))
        }
    }

    /**
     * Calculates the maximum size of the compressed data to be returned. This API uses an asynchronous callback to
     * return the result.
     *
     * @param { Int32 } sourceLen - Length of the source data.
     * @param { AsyncCallback<Int32> } callback - Callback used to return the maximum size of the compressed data.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public func compressBound(sourceLen: Int32, callback: AsyncCallback<Int32>): Unit {
        spawn {
            if (sourceLen < 0) {
                invokeAsyncCallbackParamError(callback, "compressBound")
                return
            }
            var errCode: Int32 = 0
            let bound = unsafe { FfiBundleManagerZipCompressBound(zipImpl.id, sourceLen, inout errCode) }
            invokeAsyncCallbackData(callback, errCode, bound, "compressBound")
        }
    }

    /**
     * Decompresses the compressed data into the raw data. This API uses an asynchronous callback to return the
     * result.
     *
     * @param { ArrayBuffer } dest - Destination buffer.
     * @param { ArrayBuffer } source - Source buffer.
     * @param { AsyncCallback<ZipOutputInfo> } callback - Callback used to return the result status and the total size
     *     of the destination buffer.
     * @param { ?Int64 } [sourceLen] - Length of the source data. The default value is **0**.
     * @throws { BusinessException } 17800005 - The input data is incorrect. For example, the data does not conform to
     *     the zlib compression format, the compressed data is corrupted, or the data is not compressed.
     * @throws { BusinessException } 17800007 - The input buffer is incorrect, and the output buffer is too small to
     *     accommodate the compressed or decompressed data.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func uncompress(dest: ArrayBuffer, source: ArrayBuffer, callback: AsyncCallback<ZipOutputInfo>,
        sourceLen!: ?Int64 = None): Unit {
        spawn {
            let srcLen = match (sourceLen) {
                case Some(v) => v
                case None => 0
            }
            if (srcLen > source.size || srcLen < 0) {
                invokeAsyncCallbackParamError(callback, "uncompress")
                return
            }
            let trueSrcSize = if (srcLen == 0) {
                source.size
            } else {
                srcLen
            }
            var errCode: Int32 = 0
            let vpDest = unsafe { acquireArrayRawData(dest) }
            let vpSource = unsafe { acquireArrayRawData(source) }
            var param = ZipCompressParam()
            param.destBuf = vpDest.pointer
            param.destBufLen = dest.size
            param.srcBuf = vpSource.pointer
            param.srcBufLen = trueSrcSize
            unsafe {
                FfiBundleManagerZipUnCompress(zipImpl.id, inout param, inout errCode)
                releaseArrayRawData(vpDest)
                releaseArrayRawData(vpSource)
            }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ZipOutputInfo(ReturnStatus.parse(param.outStatus), param.outDestLen)))
        }
    }

    /**
     * Initializes a decompression stream with the specified **windowBits**. This API uses an asynchronous callback to
     * return the result.
     *
     * @param { ZStream } strm - For details, see ZStream.
     * @param { Int32 } windowBits - Memory window size. The value is restricted in certain range based on the data
     *     formats. The options are as follows:<br>Zlib: [1, 15]<br>Gzip: (15, +∞)<br>Raw Deflate: [-15, -1]
     * @param { AsyncCallback<ReturnStatus> } callback - Callback used to return the result status.
     * @throws { BusinessException } 17800004 - Compression or decompression stream error, which may be caused by an
     *     initialization error in the zlib stream structure or a modified structure.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func inflateInit2(strm: ZStream, windowBits: Int32, callback: AsyncCallback<ReturnStatus>): Unit {
        spawn {
            if (!strm.checkValid()) {
                invokeAsyncCallbackParamError(callback, "inflateInit2")
                return
            }
            var errCode: Int32 = 0
            var cStrm = CZStream()
            let (nextInVp, nextOutVp) = unsafe { cStrm.initWithRawPtr(strm) }
            let ret = unsafe { FfiBundleManagerZipInflateInit2(zipImpl.id, inout cStrm, windowBits, inout errCode) }
            unsafe { cStrm.destroyRawPtr(nextInVp, nextOutVp) }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ReturnStatus.parse(ret)))
        }
    }

    /**
     * Initializes a decompression stream. This API uses an asynchronous callback to return the result.
     *
     * @param { ZStream } strm - For details, see ZStream.
     * @param { AsyncCallback<ReturnStatus> } callback - Callback used to return the result status.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public func inflateInit(strm: ZStream, callback: AsyncCallback<ReturnStatus>): Unit {
        spawn {
            if (!strm.checkValid()) {
                invokeAsyncCallbackParamError(callback, "inflateInit")
                return
            }
            var errCode: Int32 = 0
            var cStrm = CZStream()
            let (nextInVp, nextOutVp) = unsafe { cStrm.initWithRawPtr(strm) }
            let ret = unsafe { FfiBundleManagerZipInflateInit(zipImpl.id, inout cStrm, inout errCode) }
            unsafe { cStrm.destroyRawPtr(nextInVp, nextOutVp) }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ReturnStatus.parse(ret)))
        }
    }

    /**
     * Releases all dynamically allocated data structs of a decompression stream. This API uses an asynchronous
     * callback to return the result.
     *
     * @param { ZStream } strm - For details, see ZStream.
     * @param { AsyncCallback<ReturnStatus> } callback - Callback used to return the result status.
     * @throws { BusinessException } 17800004 - Compression or decompression stream error, which may be caused by an
     *     initialization error in the zlib stream structure or a modified structure.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func inflateEnd(strm: ZStream, callback: AsyncCallback<ReturnStatus>): Unit {
        spawn {
            if (!strm.checkValid()) {
                invokeAsyncCallbackParamError(callback, "inflateEnd")
                return
            }
            var errCode: Int32 = 0
            var cStrm = CZStream()
            let (nextInVp, nextOutVp) = unsafe { cStrm.initWithRawPtr(strm) }
            let ret = unsafe { FfiBundleManagerZipInflateEnd(zipImpl.id, inout cStrm, inout errCode) }
            unsafe { cStrm.destroyRawPtr(nextInVp, nextOutVp) }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ReturnStatus.parse(ret)))
        }
    }

    /**
     * Inflates data. This API uses an asynchronous callback to return the result.
     *
     * @param { ZStream } strm - For details, see ZStream.
     * @param { CompressFlushMode } flush - For details, see CompressFlushMode.
     * @param { AsyncCallback<ReturnStatus> } callback - Callback used to return the result status.
     * @throws { BusinessException } 17800004 - Compression or decompression stream error, which may be caused by an
     *     initialization error in the zlib stream structure or a modified structure.
     * @throws { BusinessException } 17800005 - The input data is incorrect. For example, the data does not conform to
     *     the zlib compression format, the compressed data is corrupted, or the data is not compressed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func inflate(strm: ZStream, flush: CompressFlushMode, callback: AsyncCallback<ReturnStatus>): Unit {
        spawn {
            if (!strm.checkValid()) {
                invokeAsyncCallbackParamError(callback, "inflate")
                return
            }
            var errCode: Int32 = 0
            var cStrm = CZStream()
            let (nextInVp, nextOutVp) = unsafe { cStrm.initWithRawPtr(strm) }
            let ret = unsafe { FfiBundleManagerZipInflate(zipImpl.id, inout cStrm, flush.getValue(), inout errCode) }
            unsafe { cStrm.destroyRawPtr(nextInVp, nextOutVp) }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ReturnStatus.parse(ret)))
        }
    }

    /**
     * Initializes a compression stream with the specified compression level, compression method, window size, memory
     * level, and compression strategy. This API uses an asynchronous callback to return the result.
     *
     * @param { ZStream } strm - For details, see ZStream.
     * @param { CompressLevel } level - For details, see CompressLevel.
     * @param { CompressMethod } method - For details, see CompressMethod.
     * @param { Int32 } windowBits - Memory window size. The value is restricted in certain range based on the data
     *     formats. The options are as follows:<br>Zlib: [1, 15]<br>Gzip: (15, +∞)<br>Raw Deflate: [-15, -1]
     * @param { MemLevel } memLevel - For details, see MemLevel.
     * @param { CompressStrategy } strategy - For details, see CompressStrategy.
     * @param { AsyncCallback<ReturnStatus> } callback - Callback used to return the result status.
     * @throws { BusinessException } 17800004 - Compression or decompression stream error, which may be caused by an
     *     initialization error in the zlib stream structure or a modified structure.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func deflateInit2(strm: ZStream, level: CompressLevel, method: CompressMethod, windowBits: Int32,
        memLevel: MemLevel, strategy: CompressStrategy, callback: AsyncCallback<ReturnStatus>): Unit {
        spawn {
            if (!strm.checkValid()) {
                invokeAsyncCallbackParamError(callback, "deflateInit2")
                return
            }
            var errCode: Int32 = 0
            var cStrm = CZStream()
            let (nextInVp, nextOutVp) = unsafe { cStrm.initWithRawPtr(strm) }
            var param = DeflateInit2Param(level.getValue(), method.getValue(), windowBits, memLevel.getValue(),
                strategy.getValue())
            let ret = unsafe { FfiBundleManagerZipDeflateInit2(zipImpl.id, inout cStrm, inout param, inout errCode) }
            unsafe { cStrm.destroyRawPtr(nextInVp, nextOutVp) }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ReturnStatus.parse(ret)))
        }
    }

    /**
     * Deflates data. This API uses an asynchronous callback to return the result.
     *
     * @param { ZStream } strm - For details, see ZStream.
     * @param { CompressFlushMode } flush - For details, see CompressFlushMode.
     * @param { AsyncCallback<ReturnStatus> } callback - Callback used to return the result status.
     * @throws { BusinessException } 17800004 - Compression or decompression stream error, which may be caused by an
     *     initialization error in the zlib stream structure or a modified structure.
     * @throws { BusinessException } 17800007 - The input buffer is incorrect, and the output buffer is too small to
     *     accommodate the compressed or decompressed data.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func deflate(strm: ZStream, flush: CompressFlushMode, callback: AsyncCallback<ReturnStatus>): Unit {
        spawn {
            if (!strm.checkValid()) {
                invokeAsyncCallbackParamError(callback, "deflate")
                return
            }
            var errCode: Int32 = 0
            var cStrm = CZStream()
            let (nextInVp, nextOutVp) = unsafe { cStrm.initWithRawPtr(strm) }
            let ret = unsafe { FfiBundleManagerZipDeflate(zipImpl.id, inout cStrm, flush.getValue(), inout errCode) }
            unsafe { cStrm.destroyRawPtr(nextInVp, nextOutVp) }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ReturnStatus.parse(ret)))
        }
    }

    /**
     * Releases all dynamically allocated data structs of a decompression stream. This API uses an asynchronous
     * callback to return the result.
     *
     * @param { ZStream } strm - For details, see ZStream.
     * @param { AsyncCallback<ReturnStatus> } callback - Callback used to return the result status.
     * @throws { BusinessException } 17800004 - Compression or decompression stream error, which may be caused by an
     *     initialization error in the zlib stream structure or a modified structure.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func deflateEnd(strm: ZStream, callback: AsyncCallback<ReturnStatus>): Unit {
        spawn {
            if (!strm.checkValid()) {
                invokeAsyncCallbackParamError(callback, "deflateEnd")
                return
            }      
            var errCode: Int32 = 0
            var cStrm = CZStream()
            let (nextInVp, nextOutVp) = unsafe { cStrm.initWithRawPtr(strm) }
            let ret = unsafe { FfiBundleManagerZipDeflateEnd(zipImpl.id, inout cStrm, inout errCode) }
            unsafe { cStrm.destroyRawPtr(nextInVp, nextOutVp) }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(ReturnStatus.parse(ret)))
        }
    }
}

/**
 * Creates this **Zip** instance. This API uses an asynchronous callback to return the result.
 *
 * @param { AsyncCallback<Zip> } callback - Callback used to return the **Zip** instance created.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public func createZip(callback: AsyncCallback<Zip>): Unit {
    spawn {
        callback(None, Some(Zip()))
    }
}

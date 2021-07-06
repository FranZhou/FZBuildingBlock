//
//  FZJSONModel.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/11.
//

import Foundation

public enum FZJSONModelError: Error {
    case stringToDataFail
    case invalidJSONObject
    case JSONObjectToDataFail
    case dataToModelFail
    case dataToModelArrayFail

    case modelToDictionaryFail
}

public let FZJSONEncoderSingeltonInstance: JSONEncoder = JSONEncoder()
public let FZJSONDecoderSingeltonInstance: JSONDecoder = JSONDecoder()

public final class FZJSONModel<T: Codable> {

}

// MARK: - model to dictionary
/// model to dictionary
extension FZJSONModel {

    public static func dictionaryFromModel(_ model: T, encoder: JSONEncoder = FZJSONEncoderSingeltonInstance) throws -> [String: Any] {
        guard let modelData = try? encoder.encode(model),
            let dictionary = try? JSONSerialization.jsonObject(with: modelData, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any]
            else {
                throw FZJSONModelError.modelToDictionaryFail
        }
        return dictionary
    }

}

// MARK: - string to model
/// string to model
extension FZJSONModel {

    public static func modelFormJSONString(_ jsonStr: String, decoder: JSONDecoder = FZJSONDecoderSingeltonInstance) throws ->T {

        do {
            guard let jsonData = jsonStr.data(using: .utf8) else {
                throw FZJSONModelError.stringToDataFail
            }

            let model = try modelFormData(jsonData)

            return model

        } catch let err as FZJSONModelError {
            throw err
        }

    }

    public static func modelArrayFormJSONString(_ jsonStr: String, decoder: JSONDecoder = FZJSONDecoderSingeltonInstance) throws -> [T] {

        do {
            guard let jsonData = jsonStr.data(using: .utf8) else {
                throw FZJSONModelError.stringToDataFail
            }

            let modelArray = try modelArrayFormData(jsonData)

            return modelArray

        } catch let err as FZJSONModelError {
            throw err
        }

    }

}

// MARK: - collection to model
/// collection to model
extension FZJSONModel {

    public static func modelFormDictionary(_ dict: [String: Any], decoder: JSONDecoder = FZJSONDecoderSingeltonInstance) throws ->T {

        do {
            guard JSONSerialization.isValidJSONObject(dict) else {
                throw FZJSONModelError.invalidJSONObject
            }

            guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
                throw FZJSONModelError.JSONObjectToDataFail
            }

            let model = try modelFormData(jsonData)
            return model

        } catch let err as FZJSONModelError {
            throw err
        }

    }

    public static func modelArrayFormArray(_ array: [Any], decoder: JSONDecoder = FZJSONDecoderSingeltonInstance) throws -> [T] {

        do {
            guard JSONSerialization.isValidJSONObject(array) else {
                throw FZJSONModelError.invalidJSONObject
            }

            guard let jsonData = try? JSONSerialization.data(withJSONObject: array, options: []) else {
                throw FZJSONModelError.JSONObjectToDataFail
            }

            let modelArray = try modelArrayFormData(jsonData)
            return modelArray

        } catch let err as FZJSONModelError {
            throw err
        }

    }

}

// MARK: - data to model or model array
/// data to model or model array
extension FZJSONModel {

    public static func modelFormData(_ data: Data, decoder: JSONDecoder = FZJSONDecoderSingeltonInstance) throws -> T {
        do {
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch _ {
            throw FZJSONModelError.dataToModelFail
        }
    }

    public static func modelArrayFormData(_ data: Data, decoder: JSONDecoder = FZJSONDecoderSingeltonInstance) throws -> [T] {
        do {
            let modelArray = try decoder.decode([T].self, from: data)
            return modelArray
        } catch _ {
            throw FZJSONModelError.dataToModelArrayFail
        }
    }

}
